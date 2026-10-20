# Plan: add the new hotel supplier "Hummingbird" to the app

Status: PLAN ONLY. No app code has been changed. Needs the owner's go-ahead (AGENTS.md R31: more than 3 files, shared hotel models).
Scope (confirmed by owner): search and the hotel list already work for Hummingbird. This plan covers what comes after the list: hotel detail, room pick, order creation, guests and review, payment, the book result, and the order screens afterwards.
Paths below are under `lib/features/hotel/`.

## 1. What this is, in simple words

Hotels come from outside suppliers: MMT, Agoda, Expedia. The web portal now also uses **Hummingbird** (the backend also has GRNC).
The app is built so each supplier has its own data classes (models), and one converter (the mapper) turns every supplier into one common room shape that all screens read. So adding Hummingbird means: add its data classes, teach the converter, and fix the few places that name suppliers one by one (booking result, markup). Screens stay almost untouched. This is AGENTS.md 14.6 rule 4, the same way MMT/Expedia/Agoda were added.

## 2. What I checked (evidence)

Web UI (UAT, one full run up to the Review step; payment not touched) and the backend repo `pragyan`:

- Details return `hotel.hummingbirdRooms[]`, flat: each entry is a room and its rate together. The hotel part has only `hummingbirdHotelId, name, checkIn, checkOut`. No address, map position, amenities, policies.
- Create order: the web sends `hotelRequest`, `selectedHotelOrder`, `requestUuid`, `userBookingContext`. The backend decides the supplier from which room list is filled. The Hummingbird branch runs `if hummingbirdRooms != null` and nothing else gates it. (The other suppliers are also gated by a top-level id the app already sets.) Branches are independent `if`s, so a leftover Hummingbird list on a non-Hummingbird choice would create a wrong itinerary.
- Update order: the web sends no supplier booking lists. The backend builds them at book time.
- Book response: Hummingbird results are in `hummingBirdBookingResponses` (capital B). Each has `requestId`, `rooms[]` (status, reservationNumber, requestNumber, externalReferenceId, hummingbirdStatus, clientRequestNumber), and `errorData`. The top-level `error` is not set. Status words the backend understands: ok / confirmed / confirmation / 1 = confirmed; hp / pending / hotel pending / pending hotel confirmation / 4 = pending; fd / failed / rejected / 2 / 3 / anything else = failed.
- Book step (what the backend needs from the saved order): for each itinerary it reads `hotel.hummingbirdHotelId`, `hotel.checkIn`, `hotel.checkOut` from the stored detail hotel, and `roomTypeCode`, `ratePlanCode`, `tariff` from `hummingbirdRooms.getFirst()`. It also needs at least one passenger per itinerary. So the app must keep `hummingbirdHotelId`, `checkIn`, `checkOut` and the chosen room in the order request, or booking fails.
- `userBookingContext` ("C" on web) is only stored on the order and echoed back; no hotel booking decision uses it. The app does not send it for any supplier today and works, so it stays unsent.
- Live data: 136 hotels in search, only 14 instant booking. Sample details: 3 rooms, each its own room type with one rate plan, all with free cancellation until a date and a penalty amount.

## 3. What breaks in the app today after the list

1. Detail response parsing drops `hummingbirdRooms`, so the room sheet is empty and `state.rooms.first` crashes the detail screen.
2. The create-order request is built from the same model, so the chosen room would not be sent and the backend would make an order with no itinerary.
3. Detail request has no place for the two Hummingbird ids (and `hotelId` is null for these hotels).
4. Book result: the app looks at MMT and Expedia lists only, so a good Hummingbird booking shows as an error. Counting "list not empty" would be wrong too, because failures and pending are inside each response.
5. `HotelDetailCommercial` lacks `rootMarkup`, `totalMarkup`, `tax`, `taxDesc`, so the `runtimeMarkUp` we send back could change the price rule.

## 4. How the existing code does it, and what I copy

| Existing pattern (checked in code) | Copy for Hummingbird |
|---|---|
| One class per file, snake_case file = class name. MMT: `details/mmt/hotel_detail_mmt_room.dart` = `HotelDetailMmtRoom`. Booking: `order/mmt/mmt_booking_response.dart` = `MmtBookingResponse` | `details/hummingbird/hotel_detail_hummingbird_room.dart` = `HotelDetailHummingbirdRoom` (backend uses the same name). `order/hummingbird/hummingbird_booking_response.dart` = `HummingbirdBookingResponse` |
| Model style 6.4: fields, constructor, copyWith, toMap (omit nulls), fromMap, toJson, fromJson, toString, ==, hashCode. JSON keys verbatim | Same. Nullable by default, safe when a key is missing (older models crash on missing lists, I will not copy that) |
| Parent keeps one nullable field per supplier (`mmtRooms`, `expediaRooms`, `agodaRooms`) | Add `hummingbirdRooms` the same way |
| Mapper `HotelMapperUtiity` has per supplier pairs: `getMmtHotelRoom`, `getExpediaHotelRoom`, `getSelectedHotelRoomMmt`, `getSelectedHotelRoomExpedia`; `getHotelRooms` adds each supplier's rooms to one list of `HotelRoom` | Add `getHummingbirdHotelRooms` and `getSelectedHotelRoomHummingbird`, and add one line in `getHotelRooms` |
| Field that must be settable back to null in copyWith uses `Nullable<T>` (`core/nullable.dart`, AGENTS 6.4) | `hummingbirdRooms` in `SearchDetailRespHotels.copyWith` uses `Nullable`, because plain `?? this` cannot clear it |
| Derived helpers on a model go in an extension in `domain/entities/` named `<name>_extensions.dart` (AGENTS 7.4) | New `hotel_booking_response_extensions.dart` |
| Unknown or unused JSON parts are left out and listed as "not modelled" (AGENTS 14.6 rule 5) | Booking room `persons[]` not modelled |
| No DI, route, Cubit change when endpoints and signatures are unchanged | None needed |

## 5. File by file

### New files (4)

1. `data/models/details/hummingbird/hotel_detail_hummingbird_room.dart` -> class `HotelDetailHummingbirdRoom`
   Fields (all nullable): `name`, `roomTypeCode`, `ratePlanCode` (String); `tariff`, `taxPercentage`, `taxAmount`, `roomBasePrice`, `tax`, `exclusivePrice`, `inclusivePrice`, `inclusivePriceWithRoot`, `totalAmount` (double); `taxInclusive`, `breakfastIncluded`, `corporateRate`, `instantBooking` (bool); `currency`, `inclusion`, `mealPlan`, `roomImage`, `cancellationPolicy` (HTML text), `freeCancellationUntil`, `cancellationPenalty` (String); `maxOccupancy` (int); `commercial` (existing `HotelDetailCommercial`). 25 fields, same as the backend class.

2. `data/models/order/hummingbird/hummingbird_booking_response.dart` -> class `HummingbirdBookingResponse`
   Fields: `requestId` (String?), `rooms` (List of the room class below, safe when missing), `errorData` (existing `ErrorCodeHandler?`).

3. `data/models/order/hummingbird/hummingbird_booking_room_response.dart` -> class `HummingbirdBookingRoomResponse`
   Fields: `status`, `externalReferenceId`, `hummingbirdStatus`, `clientRequestNumber`, `requestNumber`, `reservationNumber` (String?). Two small getters `isConfirmed` and `isPending` using the same word lists as the backend (section 2); everything else counts as failed.

4. `domain/entities/hotel_booking_response_extensions.dart` -> `extension HotelBookingResponseExtension on HotelBookingResponse`
   Two getters, `isBookingFailed` and `isBookingPending`.
   - If `hummingBirdBookingResponses` is present: failed when any response has `errorData`, has no rooms, or its first room is neither confirmed nor pending; pending when not failed and its first room is pending.
   - Otherwise: exactly today's rule for MMT/Expedia (`error?.errorData != null` or both lists empty). Pending is false. So MMT/Expedia behave as before.

### Changed files (10)

5. `data/models/details/hotel_detail_commercial.dart`: add optional `rootMarkup`, `totalMarkup` (double?), `tax` (double?), `taxDesc` (List<String>?); make `markupDesc`/`chargeDesc` parsing safe when missing. Used by: MMT rate plan, Expedia rate plan, Agoda room, `HotelBookingRequest.runtimeMarkUp`. New fields are optional, so existing suppliers behave the same.
6. `data/models/details/search_detail_res_hotel.dart`: add `hummingbirdHotelId` (String?, required by the backend book step) and `hummingbirdRooms` (List<HotelDetailHummingbirdRoom>?) to fields, constructor, toMap, fromMap, ==, hashCode, toString; in `copyWith` it is `Nullable<List<HotelDetailHummingbirdRoom>>?`. Callers of its `copyWith`: only the mapper.
7. `data/models/search/hotel_search_response.dart`: add `hummingbirdHotelId`, `hummingbirdHotelCode` (String?).
8. `data/models/details/hotel_detail_request.dart`: add `hummingbirdHotelId`, `hummingbirdHotelCode` (String?) (and see question Q2 about `hotelId`). Callers: mapper only.
9. `data/models/order/hotel-source.dart`: add `HUMMINGBIRD` (and `GRNC` only if wanted, Q4). Uses: `HotelRoom.fromMap`, mapper.
10. `domain/usecases/hotel_mapper_utiity.dart`: see section 6.
11. `data/models/order/hotel_booking_response.dart`: add `hummingBirdBookingResponses` (List<HummingbirdBookingResponse>?), exact backend key, in all the usual places (constructor, copyWith, toMap, fromMap, ==, hashCode, toString). The only reader is the payment screen.
12. `presentation/pages/hotel_payment_screen.dart` (`_handlePaymentAndBooking`): replace the inline check with `if (bookResponse.isBookingFailed) orderStatus = OrderStatusEnum.error; else if (bookResponse.isBookingPending) orderStatus = OrderStatusEnum.warning;`. Nothing else in that screen changes.
13. `presentation/widgets/detail/hotel_detail_summary_widget.dart`: address row. Use the search `geo` when the detail hotel has no latitude/longitude; hide the map tap when neither has them (today it force-unwraps and crashes).
14. `data/models/search/geo_locations.dart`: read the key `longitude` and expose it (today only `_longitude` is read and the field is private). Nothing else uses it now.

Not touched: `hotel_detail_resonse.dart` (the backend does not use a top-level Hummingbird id), service, repository, use cases, Cubits, states, routes, DI, `core/`, `pubspec.yaml`.

## 6. Mapper logic in `hotel_mapper_utiity.dart` (exactly what changes)

- `getHotelRooms`: one more line, `hotelRooms.addAll(hotelDetail?.hummingbirdRooms.. getHummingbirdHotelRooms(...) ?? [])`.
- New `getHummingbirdHotelRooms(List<HotelDetailHummingbirdRoom>)`: group entries by `roomTypeCode` (using `groupListsBy`, the `collection` package is already imported). For each group build one `HotelRoom`:
  - `id` = roomTypeCode, `name` = room name, `images` = the one `roomImage` through `getImageUrl`, `bedType`/`bedSize` = null, `hotelSourceEnum` = HUMMINGBIRD.
  - one `HotelRoomType` per rate: `id` = ratePlanCode, `name` = inclusion text, `totalcost` = totalAmount (0 if missing), amenities = inclusion, meal plan, and "Free breakfast" when `breakfastIncluded`, penalty = one row `HotelRoomPenalty(startDate: freeCancellationUntil, value: cancellationPenalty)` when a free-cancel date exists. Room types sorted by price, like Expedia.
- New `getSelectedHotelRoomHummingbird(hotel, selectedRoom)`: returns null unless the room's source is HUMMINGBIRD; otherwise the entry whose `roomTypeCode` equals `selectedRoom.id` and `ratePlanCode` equals `selectedRoom.hotelRooms.first.id` (ignoring case, as MMT does).
- `createHotelOrderRequest`: call the new selector next to the MMT/Expedia ones; add to the `hotel.copyWith(...)`: `hummingbirdRooms: Nullable(selected != null ? List.filled(hotelSearch.roomCount ?? 1, selected) : null)`. This sends only the chosen room (once per requested room, D6), and clears the list for MMT/Expedia choices so the backend cannot build a stray Hummingbird itinerary.
- `mapToHotelDetailRequest`: pass `hummingbirdHotelId` and `hummingbirdHotelCode` from the search hotel, and `hotelId: hotelSearchResponse.id ?? int.tryParse(hotelSearchResponse.hummingbirdHotelId ?? '')` (D2).
- `createHotelBookingRequest`: markup becomes `mmt commercial ?? expedia commercial ?? hummingbird commercial`.

## 7. Screen-by-screen check against the real Hummingbird data

| Screen / piece | With Hummingbird | Verdict |
|---|---|---|
| Detail: photo header (search `media`) | every hotel had 2+ photos | works |
| Detail: summary card | no review score (shows 0.0), no address, map tap would crash | change (files 13, 14) |
| Detail: amenities, check-in text, description, policies | all empty, sections hide themselves | works. Option: show the search amenities (108 of 136 had them) |
| Detail: bottom price button, room sheet | needs mapped rooms; bed type and size show "N/A" | works after file 10; "N/A" lines are cosmetic |
| Create order (room select) | `hummingbirdRooms` dropped today | change (files 1, 6, 10) |
| Book form (guests, billing, special request) | same as other suppliers | works |
| Update order and `priceData` check | web gets `priceData` | works |
| Review screen | address blank, no policies, penalty table from file 10 | works after file 10 |
| Payment: pay and book | outcome is inside the Hummingbird list | change (files 2, 3, 4, 11, 12) |
| Order status screen | pending maps to warning | works with file 12 |
| Order list card, booking detail screen, trips | name shows, address "-", photo placeholder, status "Pending Confirmation" and the voucher rule already exist | works, no change |

## 8. Order of work (bottom up, AGENTS 14.6)

1. Models: files 5, 1, 6, 7, 8, 9, 3, 2, 11, 14.
2. Extension: file 4.
3. Mapper: file 10.
4. Screens: files 12, 13.
5. After each group: `flutter analyze --no-pub <touched files>` only (R29/R32).

## 9. What I will NOT touch (R33/R35)

- Earlier spotted problems (special request never sent, empty catch in the book Cubit, price from client, other crashes). Say if you want them as a separate task.
- Pagination, filters, UI redesign. GRNC unless you say so.
- Order screens keep `mmtMedia` then `agodaMedia`; Hummingbird has none, so they show the existing hotel-icon placeholder.

## 10. Decisions I made (from the existing patterns and the backend code)

- D1 (was Q1). Do not send `rateType`, `nationality`, `userBookingContext`. The app sends none for any supplier today, the backend defaults nationality to IN, and `userBookingContext` is only echoed.
- D2 (was Q2). Details request: send `hummingbirdHotelId` and `hummingbirdHotelCode`, and for `hotelId` use `id ?? int.tryParse(hummingbirdHotelId)`. The field stays a number (no change for other suppliers); the backend turns a number or a string into its field either way. The details service is a separate hotel service that is not in the pragyan repo, so this is copied from what the web sends. The only thing the code cannot settle; I will confirm with the first real call.
- D3 (was Q3). Review page shows the free-cancel date and penalty amount in the existing penalty table. The HTML policy text stays in the model for later.
- D4 (was Q4). GRNC: not now (not confirmed, AGENTS R35). Same steps later.
- D5 (was Q5). Price shown stays the room `totalAmount`, like every other supplier.
- D6 (was Q6). Several rooms: repeat the chosen room once per requested room. The backend makes one itinerary per entry and always books `getFirst()`, so the same room for every itinerary is the only consistent choice.
- D7 (was Q7). Address on the order: leave as is (backend/data point).
- D8 (was Q8). No extras (search amenities, occupancy line). Only the confirmed work.

## 11. Open questions left

None that block starting. Say if you want to change any decision above.

## 12. (old list kept for reference)

- Q1. The web details call also sends `rateType:"HO"`, `nationality`, `userBookingContext:"C"`. The app sends none. I assume the backend defaults them (nationality defaults to IN). One replayed details call would confirm before coding file 8.
- Q2. The web sends `hotelId` as the string "171106". The app's field is a number and is null here. I would test details with only the two Hummingbird ids. If the backend needs `hotelId`, the field in file 8 becomes text.
- Q3. Cancellation on the review page: only free-cancel date and penalty amount (my default, fits the current table), or also the HTML policy text?
- Q4. Include GRNC now? Same pattern, a second pass.
- Q5. Price shown stays the room `totalAmount`, like other suppliers; the server re-prices later ("Price may be updated at checkout" on web). OK?
- Q6. Several rooms: the backend makes one itinerary per entry in `hummingbirdRooms`, matched to search room `i`. The app sends one entry today (like MMT/Expedia). My default: repeat the chosen room once per requested room. OK?
- Q7. Address: the backend copies address, pin code and lat/long from the detail hotel into the order. For Hummingbird they are empty, so the order and voucher have no address (backend/data point). Do you want the app to fill them from the search result?
- Q8. Optional: show search amenities on the detail page for Hummingbird, and max occupancy instead of the "N/A" bed lines?

## 11. How we will check it

1. Before coding: one replayed details call in the browser (Q1, Q2).
2. Run the app on dev: Mumbai search, open a Hummingbird hotel, pick a room, guests, billing entity, review, payment screen. Stop before Book Now on UAT unless you say so.
3. Re-check MMT and Expedia still list and open (shared models changed in files 5 and 6).

## 12. Test data left behind

During exploration I created one unbooked UAT order `BOMH2610200002` (Powai Palace, guest Mohit Panwar, billing entity FINBOOKTEST). No payment or booking was made.
