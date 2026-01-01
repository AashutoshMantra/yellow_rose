import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/passenger_detiald.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/segment.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_mapper_utility.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/hotel_detail_expedia_room.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_request.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/details/mmt/hotel_detail_mmt_room.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel-source.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_booking_request.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_order_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_room_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room_amenities.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room_type.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_rrom_cancellation.dart';
import 'package:yellow_rose/features/hotel/presentation/cubit/hotel_book_cubit/hotel_book_cubit.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

class HotelMapperUtiity {
  HotelMapperUtiity._();
  static HotelListSearchRequest mapToHotelSearchRequest(
      HotelSearch hotelSearch) {
    var roomRequests = List.generate(
      hotelSearch.roomCount ?? 0,
      (index) => HotelRoomRequest(
        adults: hotelSearch.adultCount ?? 0,
        childrenAges: hotelSearch.childAges ?? [],
      ),
    ).toList();
    return HotelListSearchRequest(
      checkInDate: hotelSearch.checkInDate!,
      checkOutDate: hotelSearch.checkOutDate!,
      city: hotelSearch.place!.city!,
      country: hotelSearch.place!.countryCode!,
      rooms: roomRequests,
      roomCount: hotelSearch.roomCount ?? 0,
      pageNo: 1,
      pageSize: null,
    );
  }

  static HotelDetailRequest mapToHotelDetailRequest(
      HotelSearch hotelSearch, HotelSearchResponse hotelSearchResponse) {
    return HotelDetailRequest(
      hotelId: hotelSearchResponse.id,
      checkInDate: hotelSearch.checkInDate!,
      checkOutDate: hotelSearch.checkOutDate!,
      country: hotelSearch.place!.countryCode!,
      roomCount: hotelSearch.roomCount ?? 0,
      requestId: hotelSearch.requestId,
      rooms: List.generate(
        hotelSearch.roomCount ?? 0,
        (index) => HotelRoomRequest(
          adults: hotelSearch.adultCount ?? 0,
          childrenAges: hotelSearch.childAges ?? [],
        ),
      ),
    );
  }

  static HotelOrderRequest createHotelOrderRequest(HotelDetailResponse hotel,
      HotelRoom selectedRoom, HotelSearch hotelSearch,
      {TripResponse? trip}) {
    var hotelSearchMapped = mapToHotelSearchRequest(hotelSearch);
    var selectedHotelOrder = hotel;
    var mmtRoomSelected = getSelectedHotelRoomMmt(hotel, selectedRoom);
    var expediaRoomSelected = getSelectedHotelRoomExpedia(hotel, selectedRoom);
    var randomUid = const Uuid().v4();
    selectedHotelOrder = selectedHotelOrder.copyWith(
        expediaSessionId: expediaRoomSelected != null ? randomUid : null,
        mmtRequestId: mmtRoomSelected != null ? randomUid : null,
        hotel: hotel.hotel?.copyWith(
            mmtRooms: mmtRoomSelected != null ? [mmtRoomSelected] : null,
            expediaRooms:
                expediaRoomSelected != null ? [expediaRoomSelected] : null));
    return HotelOrderRequest(
        requestUuid: randomUid,
        source: selectedRoom.hotelSourceEnum.name,
        hotelRequest: hotelSearchMapped,
        tripUid: trip?.tripUid,
        selectedHotelOrder: selectedHotelOrder);
  }

  static HotelBookingRequest createHotelBookingRequest(
      HotelBookLoaded hotelLoadedState) {
    var passengerDetails =
        mapPassengerDetails(hotelLoadedState.passengerDetails);
    var billingEntity = hotelLoadedState.billingEntity;
    var firstPasseger = passengerDetails.first;
    var mmtRoomSelected = getSelectedHotelRoomMmt(
        hotelLoadedState.hotel, hotelLoadedState.selectedRoom);
    var expediaRoomSelected = getSelectedHotelRoomExpedia(
        hotelLoadedState.hotel, hotelLoadedState.selectedRoom);
    var markup = mmtRoomSelected?.ratePlans?.firstOrNull?.commercial ??
        expediaRoomSelected?.rates?.firstOrNull?.commercial;
    return HotelBookingRequest(
        mmtBookingRequestList: [],
        expediaBookingRequestList: [],
        gstEmail: billingEntity?.email,
        gstNumber: billingEntity?.entityGST,
        billingEntity: billingEntity?.entityRefId,
        contactNumber: firstPasseger.mobile,
        email: firstPasseger.email,
        runtimeMarkUp: markup,
        passengerDetails: passengerDetails);
  }

  static List<PassengerDetails> mapPassengerDetails(
      List<PassengerDetailsEntity> passengerDetails) {
    var adultCount =
        passengerDetails.where((d) => d.passengerType.isAdult()).length;
    var childCount =
        passengerDetails.where((d) => d.passengerType.isChild()).length;

    return passengerDetails.map((passenger) {
      return PassengerDetails(
          firstName: passenger.name,
          lastName: passenger.lastName,
          passengerTitle: passenger.title.name,
          passengerType: passenger.passengerType.getPassengerTypeEnum,
          mobile: passenger.phoneNumber,
          gender: passenger.gender.name,
          dob: passenger.dob,
          reportingTags: [],
          email: passenger.email);
    }).toList();
  }

  static HotelDetailMmtRoom? getSelectedHotelRoomMmt(
    HotelDetailResponse hotel,
    HotelRoom selectedRoom,
  ) {
    if (selectedRoom.hotelSourceEnum != HotelSourceEnum.MMT) {
      return null;
    }
    var allMmtRooms = hotel.hotel?.mmtRooms;
    var roomSelected = allMmtRooms?.firstWhereOrNull(
        (room) => room.code?.equalsIgnoreCase(selectedRoom.id) == true);
    var selectedRoomType = roomSelected?.ratePlans
        ?.where((roomRate) =>
            roomRate.code
                ?.equalsIgnoreCase(selectedRoom.hotelRooms.first.id ?? '') ==
            true)
        .toList();
    roomSelected = roomSelected?.copyWith(ratePlans: selectedRoomType);
    var roomTypeSelected;
    return roomSelected;
  }

  static HotelDetailExpediaRoom? getSelectedHotelRoomExpedia(
    HotelDetailResponse hotel,
    HotelRoom selectedRoom,
  ) {
    if (selectedRoom.hotelSourceEnum != HotelSourceEnum.EXPEDIA) {
      return null;
    }
    var allMmtRooms = hotel.hotel?.expediaRooms;
    var roomSelected = allMmtRooms?.firstWhereOrNull(
        (room) => room.id?.equalsIgnoreCase(selectedRoom.id) == true);
    var selectedRoomType = roomSelected?.rates
        ?.where((roomRate) =>
            roomRate.id
                ?.equalsIgnoreCase(selectedRoom.hotelRooms.first.id ?? '') ==
            true)
        .toList();
    roomSelected = roomSelected?.copyWith(rates: selectedRoomType);
    var roomTypeSelected;
    return roomSelected;
  }

  static String? getImageUrl(String? url) {
    if (url?.contains("https") == true) {
      return url;
    }
    return url?.replaceFirst("//", 'https://');
  }

  static List<HotelRoom> getHotelRooms(
      HotelDetailResponse hotelDetailResponse) {
    var hotelDetail = hotelDetailResponse.hotel;
    List<HotelRoom> hotelRooms = [];
    var expediaRooms =
        hotelDetail?.expediaRooms?.map(getExpediaHotelRoom).toList();
    var mmtRooms = hotelDetail?.mmtRooms?.map(getMmtHotelRoom).toList();
    hotelRooms.addAll(expediaRooms ?? []);
    hotelRooms.addAll(mmtRooms ?? []);
    return hotelRooms;
  }

  static HotelRoom getExpediaHotelRoom(HotelDetailExpediaRoom expediaRoom) {
    var id = expediaRoom.id;
    var bedType = expediaRoom.roomMeta?.bedGroups?.firstOrNull?.description;
    var bedSize = expediaRoom.roomMeta?.area?.squareFeet?.toString();
    var images = expediaRoom.images
        .expand((image) => ((image.links ?? []).toList()))
        .map((image) => image.href)
        .nonNulls
        .toList();
    var roomName = expediaRoom.roomName;
    List<HotelRoomType> hotelRoomType =
        (expediaRoom.rates ?? []).map((exediaRates) {
      var id = exediaRates.id;
      var totalCost = exediaRates.totalPrice?.requestedCurrencyTotalPrice;
      var cancelpenalty = exediaRates.cancelPenalties?.map((cancelPenalty) {
        var startdata = cancelPenalty.start;
        var endData = cancelPenalty.end;
        var value = cancelPenalty.percent?.toString();
        return HotelRoomPenalty(
            endDate: endData, startDate: startdata, value: value);
      }).toList();
      var amenities =
          exediaRates.amenities?.where((am) => am.name != null).map((aminity) {
        return HotelRoomAmenities(id: aminity.id, name: aminity.name!);
      }).toList();
      return HotelRoomType(
          id: id ?? '',
          totalcost: totalCost ?? 0,
          hotelRoomAmenities: amenities,
          hotelRoomPenalty: cancelpenalty);
    }).toList();
    hotelRoomType.sort((a, b) => a.totalcost.compareTo(b.totalcost));
    return HotelRoom(
        id: id!,
        name: roomName,
        bedSize: bedSize,
        bedType: bedType,
        images: images ?? [],
        hotelSourceEnum: HotelSourceEnum.EXPEDIA,
        hotelRooms: hotelRoomType);
  }

  static HotelRoom getMmtHotelRoom(HotelDetailMmtRoom expediaRoom) {
    var id = expediaRoom.code;
    var bedType = expediaRoom.metadata?.beds?.firstOrNull?.type;
    var bedSize = expediaRoom.metadata?.roomSize;
    var images = expediaRoom.media?.map(getImageUrl).nonNulls.toList();
    var roomName = expediaRoom.metadata?.name ?? expediaRoom.name;
    List<HotelRoomType> hotelRoomType =
        (expediaRoom.ratePlans ?? []).map((exediaRates) {
      var id = exediaRates.code;
      var totalCost = exediaRates.totalAmount;
      var cancelpenalty =
          exediaRates.cancellationPolicy?.penalties?.map((cancelPenalty) {
        var startdata = cancelPenalty.startDate;
        var endData = cancelPenalty.endDate;
        var value = cancelPenalty.penaltyValue?.toString();
        return HotelRoomPenalty(
            endDate: endData, startDate: startdata, value: value);
      }).toList();
      var amenities =
          exediaRates.inclusions?.where((am) => am.name != null).map((aminity) {
        return HotelRoomAmenities(id: aminity.name, name: aminity.name!);
      }).toList();
      return HotelRoomType(
          name: exediaRates.description,
          id: id ?? '',
          totalcost: totalCost!,
          hotelRoomAmenities: amenities,
          hotelRoomPenalty: cancelpenalty);
    }).toList();
    return HotelRoom(
        id: id!,
        name: roomName,
        bedSize: bedSize,
        bedType: bedType,
        images: images ?? [],
        hotelSourceEnum: HotelSourceEnum.MMT,
        hotelRooms: hotelRoomType);
  }
}
