# AGENTS.md - Gilpin Travels (`yellow_rose`) engineering rulebook

> Single source of truth for how code is written in this repository. Applies to every AI coding agent (Claude Code, Copilot, Cursor, Codex, Gemini, Windsurf, ...) and to human contributors.
> Verified against `lib/` (500 Dart files, git HEAD `458d946`) with repo-wide greps and counts; the largest UI files were read selectively, then audited a second time. Every rule is either what the existing code does in most places, or something the owner asked for explicitly. Counts are a 2026-10-17 snapshot.

**Your job: produce code that is indistinguishable from the owner's own code.** Same structure, same shared widgets and helpers, same naming, same look and feel. You are not here to improve, modernise, simplify or re-architect anything.

---

## 1. How to use this file

1. Read section 2 (Hard rules) completely. They apply to every task.
2. Then read the sections for your task:

| Task | Read |
|---|---|
| New or changed screen / widget | 4.3, 10, 11, 12, 13 |
| New API / backend call (curl or sample JSON) | 14.6, 18.2, 6, 7, 8 |
| Booking / payment / trip-aware flow | 14.5, 10.2, `booking_detailed_screen.dart` |
| New Cubit / state | 9 |
| New model / entity / enum | 5, 6.4, 7.4 |
| New common widget / extraction | 13, 12, 16.5 |
| New feature (product) end to end | 4, 18.3, then everything above |
| Anything that touches another feature | 14, 12.5 |
| Exact spelling of a legacy name | 16.1, then grep |

3. Before writing, open the closest golden sample (4.4) and mirror its shape (not its flaws).
4. Precedence: this file > your own habits and "best practices" > neighbouring legacy code that breaks these rules (section 16). Only the owner's explicit instruction in the current task can override a rule here, and only for that task. AI agents must never relax a rule on their own. If a rule blocks the task, finish what you can within the rules, then say which rule got in the way and why.
5. If a decision is not covered, choose what the nearest golden sample does and state the assumption in your final message. If it needs a new colour, token, package, folder convention, global Cubit or route-level change, ask the owner.

---

## 2. Hard rules (never break)

### Process
- **R1 Look first.** Open the nearest sibling file of the same kind and the reuse catalog (section 12) before creating anything. Mirror its structure, naming, import grouping and formatting.
- **R2 Reuse, never re-implement.** Anything listed in section 12 must be used. A second version of an existing widget / util / formatter is a defect, even if "slightly different" or "only for this screen".
- **R3 Extract, don't copy.** If the UI or logic you need already exists in another file, or you are about to write it for the second time, extract it (section 13) instead of pasting it.
- **R4 Smallest diff.** Change only what the task needs. No drive-by refactors, renames, re-formatting, import re-ordering or clean-ups of untouched code. Never rename legacy-misspelled files / classes / parameters (section 16.1).
- **R5 No new packages, no codegen, no config edits.** Do not touch `pubspec.yaml`, `pubspec.lock`, `analysis_options.yaml`, `app_config.yaml`, `android/`, `ios/` unless asked. No `build_runner`, `freezed`, `json_serializable`.
- **R6 Secrets.** Never open, print, copy or commit `config_secret.json` or any `*_secret.*`. Keys come in through `--dart-define`.
- **R7 Honest reporting.** State what you ran (analyze / format / app) and what you did not. List any rule you could not satisfy and why. Do not commit, push or branch unless asked.

### Architecture
- **R8 Layers.** `presentation -> domain (use case) -> data (repository -> service)`. Widgets and Cubits talk to use cases only. They never touch Dio, `DioClient`, services, repositories, Hive or SharedPreferences (section 4.2).
- **R9 Every API is Service -> Repository -> UseCase**, each an `abstract interface class` plus an `...Impl`, even when it is a pure pass-through (sections 6 and 7). Hotel, `TripService` and recent-search use plain `abstract class`: older style, do not copy.
- **R10 DI is GetIt with field initialisers.** Register `registerLazySingleton<Abstract>(() => Impl())` in `lib/dependncy_injection.dart`; consume with `final _x = getIt<X>();`. No constructor injection, no `registerFactory`, Cubits are never registered (section 8).
- **R11 State is Cubit + Equatable + `part` / `part of` state file.** No Bloc events, Provider, Riverpod, GetX, ChangeNotifier. `setState` and `ValueNotifier` are only for ephemeral, widget-local UI state (section 9).
- **R12 Navigation is named routes** registered in `AppRouter.onGenerateRoute` (`lib/app_routes.dart`), pushed with the screen's `routeName` constant and a `Map` of arguments (section 10.4).
- **R13 Cross-feature reuse is use case -> use case**, plus importing the owner feature's models / entities. Never call another feature's service or repository. Never re-implement an endpoint another feature already owns (section 14).
- **R14 Absolute imports only** (`package:yellow_rose/...`), never relative (the only exception is 9 legacy relative imports inside `bus/presentation/widgets/seat/`; do not copy). Never import a wrapped package where a wrapper exists (section 12.6). `getIt` comes from `package:yellow_rose/dependncy_injection.dart`, not from `get_it`.

### UI system
- **R15 Every dimension is `.h` / `.w`** (`core/utils/size_config.dart`): width, height, padding, margin, gap, radius, icon size, avatar radius. Not `flutter_screenutil`, not `.sp` / `.r`, not raw numbers (exceptions in 11.1).
- **R16 Colours come from `AppColors`** (plus `Colors.white`, `Colors.transparent`, and `Colors.black` only as a shadow / scrim with opacity). No hex / `Color(0x..)`, no other `Colors.*` hues, no `Theme.of(context)` colour reads. Missing colour: add it to `core/theme/app_colors.dart` first (ask the owner).
- **R17 Text comes from `TextStyles.<name>Style()`**, adjusted only with `.copyWith(color: ...)`. No `TextStyle(...)`, `fontSize:`, `fontFamily:`, `GoogleFonts`, `Theme.of(context).textTheme`.
- **R18 Use the common widgets** for buttons, text fields, dropdowns, app bars, bottom action bars, loaders, pills / chips, banners, sheet headers, key/value rows, date picker, tabs (section 12.1). Where the catalog has no equivalent (`IconButton`, `TextButton`, `OutlinedButton.icon`, `FloatingActionButton`, `Divider`, `Card`) use the Material widget with theme defaults; when you need it a third time, make it a common widget (R3).
- **R19 Snackbars, dialogs, popups and bottom sheets go through `WidgetUtil`** (`core/utils/WidgetUtils.dart`). Never `ScaffoldMessenger`, `SnackBar`, `showDialog`, `showGeneralDialog`, `showModalBottomSheet`, `AlertDialog`. For dates use `DatePicker` in `WidgetUtil.showBottomSheet`; if it lacks an option you need (for example `maxDate`), add an optional parameter to it instead of calling `showDatePicker`.
- **R20 Loading is `Loader`** (page: `const Loader()`; inline: `Loader(color: Colors.transparent)`). Button progress is `CustomButton(buttonController:)`. No bare `CircularProgressIndicator`.
- **R21 Dates, currency, enum and string helpers come from core.** Format with `CustomDateUtils`, parse API dates per 6.4, use `toEnum` / `stringToEnum` / `toTitleCase` / `equalsIgnoreCase`. No new `DateFormat(...)` in feature code (section 15).
- **R22 Feature widget vs common widget.** Used by one feature: `features/<f>/presentation/widgets/`. Used by 2+ features or generic: `core/common_widgets/`. A private copy of a common widget inside a feature is forbidden.
- **R23 Widget shape.** `const Foo({super.key, required this.x})`, every field `final`, `StatelessWidget` by default; `StatefulWidget` only for controllers / animation / ephemeral state; `const` wherever legal (a subtree that uses `.h` / `.w` cannot be `const`).

### Hygiene
- **R24 Comments: none by default.** If needed, a short plain `//` saying why. Never emoji, `// ...existing code...`, commented-out code, banner comments or new `TODO`s.
- **R25 Logging: `log()` from `dart:developer`** (`log("$e $s")`). Never `print` / `debugPrint`.
- **R26 Names:** spell identifiers correctly (never copy legacy typos), follow section 5, file name = class name in snake_case.
- **R27 Models** use the generator style in 6.4 (`copyWith`, `toMap`, `fromMap`, `toJson`, `fromJson`, `toString`, `==`, `hashCode`).
- **R28 `context` after `await`:** guard with `mounted`, or capture the navigator / cubit before the await.
- **R29 Quality gate:** `flutter analyze --no-pub <touched files>` shows no new errors or warnings from your change; format only your own lines (18.5).
- **R30 User-facing copy** follows section 15.

### Working protocol
- **R31 Announce before you change.** Before editing any file, tell the owner in plain, short language what you are about to change, in which files and why. Wait for a go-ahead when the change is non-trivial (definition below). A change the owner asked for in the current message that stays inside one feature folder (up to 3 files) needs only the announcement, not the wait. Work in small steps and say what each step did. Never silently change anything, including "tiny" renames or clean-ups.
- **R32 Spend resources sparingly.** After a change, check only what you touched: `flutter analyze --no-pub <touched files>` once when a logical piece is done (not after every edit), `dart format` only on files that were format-clean. Never run project-wide `flutter analyze`, `dart format .`, `dart fix`, `flutter test`, `flutter pub get/upgrade`, `flutter clean` or a full build as routine follow-up; run them only when the owner asks. Do not re-read or re-scan the whole codebase for a small task; read the golden sample and the files you change.
**Non-trivial = wait for the owner's go-ahead.** Any change that (a) touches shared code: `lib/core/`, `lib/app_routes.dart`, `lib/dependncy_injection.dart`, a common widget, a shared model in another feature's folder, a global Cubit; (b) touches more than 3 files or creates more than 1 new file; (c) adds a route, Hive box, asset, dependency or colour / style token; (d) renames, moves or deletes anything; (e) changes behaviour of existing code instead of adding to it.

Good "before I change anything" message: "I will add a `getVisaRules` call to the auth feature. Files: new `visa_rule_response.dart` in auth/data/models, one method each in `auth_service.dart`, `auth_repo.dart`, `auth_repo_impl.dart`, `auth_use_case.dart`; no DI change. It touches 5 files, so I need your OK. Is the response a list or an object?"

Good final summary: files changed (one line each: what and why); shared widgets reused or created; what was run (`flutter analyze --no-pub <files>`) and what was not; rules not met; Spotted list.

- **R34 Read the whole feature before you propose a change.** When a task touches an existing feature (for example "change trips"), first read that feature end to end (service, repository, use case, models, Cubit, state, every screen and widget) and everything connected to it: grep every caller and consumer of any type, enum or helper you would change (`grep -rn "TypeName" lib`), and check the shared kernel in section 14. Only then propose changes, each with the files it touches and what else uses them. A proposal made from a summary or a backend document alone is not allowed; backend documents describe the server, not what the app does today, and where they disagree with working app behaviour, ask. Example of the failure this prevents: changing `TripType` to add a "direct booking" value would have stopped every `== TripType.PostBooking` check in flight, hotel and bus from booking.
- **R35 Only do what is confirmed.** If the owner says some changes are not decided yet (pending backend or policy answers), do not touch them and do not guess; do the confirmed part and list the rest as pending.
- **R33 Notice, don't act.** While working, if you see a duplicate, a missing common widget, a bug or a better approach, do not fix it unasked. Add it to a short "Spotted" list in your final message (file, what, suggested fix) so the owner can decide.

---

## 3. Project snapshot

| Item | Value |
|---|---|
| Product | "Gilpin Travels": corporate travel booking (flights, hotels, buses) plus corporate trips with approval workflows. Cabs and insurance are "coming soon" placeholders only |
| Package / ids | `yellow_rose` / `com.linuxmantra.travels` |
| Toolchain | Flutter 3.35.2, Dart 3.9 (`sdk: ^3.5.3`), Material 3, light theme only, hard-coded English strings (no l10n, no dark mode) |
| Flavors | `dev`, `prod` (`--flavor`). `app_config.yaml` holds `apiBaseUrl` per flavor, exposed by `AppConfig.instance` |
| Secrets | `config_secret.json` (git-ignored via `*_secret.*`) passed with `--dart-define-from-file`, read with `String.fromEnvironment` (`GOOGLE_API_KEY`) |
| Run | `flutter run --flavor dev --target lib/main.dart --dart-define-from-file=config_secret.json` |
| Backend | REST JSON through `DioClient`; `Authorization: Bearer <token>` is injected from the Hive `userProfile` box |
| Local storage | Hive boxes `airports`, `userProfile`, `bus_cities` (registered in `HiveSetup`); `SharedPreferencesRepository` for small values (recent searches, update-prompt state) |
| Other services | Firebase Crashlytics (hooks in `main()`), Firebase Remote Config (min / latest app version), Google Places (hotel city search) |
| Analyzer baseline | 873 pre-existing issues (0 errors, 226 warnings, 647 infos) with plain `flutter_lints`. Do not "fix" them in passing |
| Tests | No meaningful suite. `test/widget_test.dart` is the untouched Flutter template and fails. Ignore it; do not add tests unless asked |
| Git | Single author, short lowercase commit messages. Do not commit unless asked |

Startup order (`main.dart`): `HiveSetup.init()` -> `AppConfig.loadConfig()` + `setupDependencyInjection()` -> Crashlytics hooks -> `MyApp` = `MultiBlocProvider(TripCubit, HomeScreenCubit, AuthCubit..appStarted(), AppUpdateCubit..checkForUpdates())` -> `LayoutBuilder` + `OrientationBuilder` call `SizeConfig().init(...)` -> `MaterialApp(theme: AppTheme.lightThemeData(context), onGenerateRoute: AppRouter.onGenerateRoute, home: BlocBuilder<AuthCubit>)`.

---

## 4. Architecture and placement

### 4.1 Folder map

```
lib/
  main.dart                     bootstrap, global BlocProviders, MaterialApp, routeObserver
  app_routes.dart               ALL named routes (AppRouter.onGenerateRoute) + formatScreenName()
  dependncy_injection.dart      ALL GetIt registrations; consumers import it to get `getIt`
  core/
    app_config.dart             flavor config (apiBaseUrl, googleApiKey)
    nullable.dart               Nullable<T>: lets copyWith set a field to null
    common_widgets/             shared UI kit (12.1); passenger_detail/ is a shared module
    constants/                  airline_code.dart, supported_service.dart
    storage/hive_setup.dart     Hive box registry
    theme/                      app_colors.dart, text_styles.dart, theme.dart
    utils/                      size_config, WidgetUtils, date_utils, date_time_parser, dio_client,
                                extensions, common_utils, form_filed_config, shared_pref_repository,
                                remote_config_service, order_invoice_downloader, trip_validation_helper
  features/
    auth/  bus/  flight/  home_screen/  hotel/  trip/
      data/
        datasources/            <x>_service.dart (remote), <x>_local_service.dart (Hive / prefs)
        models/[group/]         request / response JSON classes
        repositories/           <x>_repository_impl.dart
      domain/
        entities/[group/]       UI-facing classes, search params, enums, extensions
        repositories/           <x>_repository.dart (abstract interface)
        usecases/               <x>_usecase.dart (interface + Impl), <x>_mapper_utility.dart
      presentation/
        cubit/[group/]          <x>_cubit.dart + <x>_state.dart (one sub-folder per cubit when the feature has several)
        pages/[group/]          <x>_screen.dart
        widgets/[group/]        feature-scoped widgets
```

### 4.2 Layer rules

- `presentation` imports: its own `domain/*`, `data/models/*` (models are used directly in UI here), `core/*`, other features per section 14.
- `domain/usecases` imports: `data/models`, `domain/repositories`, other features' use cases and models, `core/utils`.
- `data/*` imports: `core/utils/dio_client.dart`, `core/app_config.dart`, models. No Flutter UI.
- Common widgets may take a feature's *model* as a parameter (existing: `GstInfoCard(BillingEntity)`) but must not import a feature's cubits or pages. Existing violations (`WidgetUtil`, `passenger_detail/*`) are legacy; do not add more.

### 4.3 Where does it go?

| You are adding | Put it in |
|---|---|
| Backend call | `features/<f>/data/datasources/<f>_service.dart`, then repository, then use case |
| Request / response JSON class | `features/<f>/data/models/[group/]<name>.dart` |
| Search params, UI entity, enum, extension | `features/<f>/domain/entities/` |
| Entity -> request mapping | `features/<f>/domain/usecases/<f>_mapper_utility.dart` |
| Screen | `features/<f>/presentation/pages/<name>_screen.dart` + route in `app_routes.dart` |
| Bottom-sheet screen (filters, pickers) | same `pages/` folder, `Screen` suffix |
| Widget for one feature | `features/<f>/presentation/widgets/` |
| Widget for 2+ features or generic | `core/common_widgets/` |
| Pure helper (no UI) | extend an existing class in `core/utils/` first |
| App-wide constant / enum | `core/constants/` |
| Colour / text style / theme | `core/theme/` |
| Persistence | `<f>_local_service.dart` (+ box name in `HiveSetup._boxes`) |
| App-wide Cubit | `main.dart` MultiBlocProvider (ask the owner first) |

### 4.4 Golden samples (copy their shape, not their flaws)

| Recipe | Sample |
|---|---|
| Service / repository / use case / mapper | `features/bus/**` (trip and hotel use plain `abstract class`; trip splits the Impl into `trip_usecase_impl.dart`: do not copy that) |
| Request / response model | `auth/data/models/sign_in_request.dart`, `bus/data/models/bus_point.dart`, `trip/data/models/trip_response.dart` |
| Domain entity with copyWith / equality | `bus/domain/entities/bus_search.dart` |
| Async-flow Cubit + sealed state | `bus_search_listing_cubit.dart` + `_state.dart`, `hotel_book_cubit.dart` + `hotel_book_state.dart` (`trip_state.dart` is `abstract`, global-cubit style) |
| Form Cubit + single-class state | `bus/.../search/bus_search_cubit.dart` + `_state.dart`, `auth/.../sign_in_form_cubit.dart` |
| Multi-step flow sharing one Cubit | `bus_book_cubit.dart`, `bus_book_form_screen.dart`, `bus_booking_review_screen.dart` |
| Search screen + search card widget | `bus_search_screen.dart` + `widgets/bus_search_widget.dart` |
| List screen with filter FAB | `bus_search_list_screen.dart` |
| Bottom-sheet screens | `bus_search_filter_screen.dart`, `bus_city_search_screen.dart` |
| Card widgets | `bus/widgets/bus_search_result_card.dart`, `bus/widgets/bus_section_card.dart` (`trip_card.dart` uses off-palette colours) |
| Payment / book handler (trip-aware) | `flight/presentation/pages/booking_detailed_screen.dart` `_handlePaymentAndBooking` and its Pay button (14.5); not `bus_booking_review_screen` (legacy Navigator.push) |
| Newest UI conventions (private `_buildX`, `mounted`, sheet form) | `trip_home_screen.dart`, `create_trip_bottom_sheet.dart` |
| Route registration | `lib/app_routes.dart` (bus and hotel cases) |

---

## 5. Naming

| Thing | Rule | Example |
|---|---|---|
| Dart file | `snake_case.dart`; suffix states the role; class name = PascalCase of file name | `bus_search_result_card.dart` -> `BusSearchResultCard` |
| Screen | `<name>_screen.dart` / `<Name>Screen` | `BusSearchListScreen` |
| Widget | `<name>_widget.dart`, or a noun suffix: `_card`, `_tile`, `_sheet`, `_button`, `_banner`, `_pill`, `_row` | `bus_passenger_tile.dart` |
| Cubit / state | `<name>_cubit.dart` / `<Name>Cubit`; `<name>_state.dart` / `<Name>State` | `BusBookCubit`, `BusBookState` |
| State subclasses | `<Name>Initial`, `<Name>Loading`, `<Name>Loaded`, `<Name>Error`; error field `errorMessage` | `BusBookError(this.errorMessage)` |
| Service | `<name>_service.dart`: `abstract interface class <Name>Service` + `<Name>ServiceImpl` in the same file; local: `<name>_local_service.dart` | `BusServiceImpl` |
| Repository | domain `<name>_repository.dart`; data `<name>_repository_impl.dart` -> `<Name>RepositoryImpl` | `TripRepositoryImpl` |
| Use case | `<name>_usecase.dart`: `abstract interface class <Name>UseCase` + `<Name>UseCaseImpl` in the same file | `BusUseCaseImpl` |
| Mapper | `<name>_mapper_utility.dart` -> `<Name>MapperUtility` (static, private constructor) | `BusMapperUtility` |
| Models | `<noun>_request.dart`, `<noun>_response.dart`; domain nouns without suffix | `sign_in_request.dart` |
| Extensions | `<name>_extensions.dart`, `extension <Name>Extension on Type` | `user_booking_profile_extensions.dart` |
| Route name | `static const String routeName = "/<lowerCamelClassName>";` (double quotes) | `"/busSearchListScreen"` |
| Private members | `_camelCase`; screen-local widget classes `_Name` | `_buildBody`, `_Tag` |
| Variables | camelCase; booleans `isX` / `hasX` / `shouldX` | `isSelected`, `shouldHaveRadius` |
| Cubit methods | verbs for loads: `loadX`, `searchX`, `createX`, `updateX`; input: `onXChange(value)`, `onSelectX`, `onAddUpdateX`, `toggleX`; derived data as getters | `onSourceChange`, `getFilteredBuses()` |
| Callbacks | follow the widget family: `onClick` (BottomButton, PillButton, ImageIconButton, ShowRecentSearchesWidget), `onTap` (cards), `onSearchClick`, `onChange(d)`, `onRemove`, `onAddUpdate` | |
| Assets | literal path strings, e.g. `"assets/images/icons/air.png"`; no asset-constants file | |

Enum values depend on the enum's role:
- UI variant of a widget: lowerCamel (`ButtonType.primary`, `PillType.secondary`, `BannerType.info`).
- Backend-coded value: UPPER, mirroring the backend token (`PassengerType.ADT`, `TripApprovalStatus.APPROVE`, `TripStatusEnum.SELFAPPROVED`). The `constant_identifier_names` infos this causes are expected.
- Domain / filter enum: when extending an existing one keep its style (`TripFor.OnBehalfOf`, `FlightTiming.EarlyMorning`); a brand-new domain enum with display text uses lowerCamel with named fields and a `fromCode` factory, like `BusBookingStatus`.

---

## 6. Data layer

### 6.1 Service (remote)

```dart
// features/thing/data/datasources/thing_service.dart
import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/thing/data/models/thing_request.dart';
import 'package:yellow_rose/features/thing/data/models/thing_response.dart';

abstract interface class ThingService {
  Future<List<ThingResponse>> getThings(String userId);
  Future<ThingResponse> createThing(ThingRequest request);
}

class ThingServiceImpl implements ThingService {
  final _dioClient = getIt<DioClient>();

  @override
  Future<List<ThingResponse>> getThings(String userId) async {
    var response = await _dioClient
        .get('${AppConfig.instance.apiBaseUrl}/things/list/$userId');
    var things = List<ThingResponse>.empty(growable: true);
    for (var thing in (response.data as List)) {
      things.add(ThingResponse.fromMap(thing));
    }
    return things;
  }

  @override
  Future<ThingResponse> createThing(ThingRequest request) async {
    var response = await _dioClient.post(
        "${AppConfig.instance.apiBaseUrl}/things/save",
        data: request.toMap());
    return ThingResponse.fromMap(response.data);
  }
}
```

Rules:
- One interface + one Impl per file; the field is `final _dioClient = getIt<DioClient>();`. Never create another `Dio`.
- URL = `"${AppConfig.instance.apiBaseUrl}/<path>"`; ids appended as `/$id`. Search / create endpoints are mostly `post` with `data: request.toMap()`.
- No `try/catch` unless there is a defined fallback; errors propagate to the Cubit. Backend-level failures are thrown: `throw Exception(response.data["message"] ?? "Something went wrong")`.
- No `BuildContext`, no UI, no logging of payloads.

### 6.2 Local service

```dart
abstract interface class ThingLocalService {
  Future<List<ThingResponse>> getThings();
  Future<void> cacheThings(List<Map<String, dynamic>> things);
}

class ThingLocalServiceImpl implements ThingLocalService {
  final Box thingBox = Hive.box('things');
  // get: (thingBox.get('thing_list', defaultValue: []) as List).cast<Map<dynamic, dynamic>>().map(ThingResponse.fromMap).toList()
  // cache: await thingBox.put('thing_list', things);
}
```
A new Hive box must be added to `HiveSetup._boxes`. Small key/value data uses the static `SharedPreferencesRepository` API.

### 6.3 Repository

```dart
// domain/repositories/thing_repository.dart
abstract interface class ThingRepository {
  Future<List<ThingResponse>> getThings(String userId);
}

// data/repositories/thing_repository_impl.dart
class ThingRepositoryImpl implements ThingRepository {
  final _thingService = getIt<ThingService>();

  @override
  Future<List<ThingResponse>> getThings(String userId) async {
    return await _thingService.getThings(userId);
  }
}
```
Pass-through by default. Caching (memory list + local service fallback + API) lives here, see `BusRepositoryImpl.getBusCities` / `AirRepositoryImpl.getAirports`.

### 6.4 Models (`data/models`, "Dart Data Class Generator" style)

```dart
import 'dart:convert';

import 'package:yellow_rose/core/utils/date_utils.dart';

class BusPoint {
  final String? bpId;
  final String? location;
  final DateTime? time;

  BusPoint({this.bpId, this.location, this.time});

  BusPoint copyWith({String? bpId, String? location, DateTime? time}) {
    return BusPoint(
      bpId: bpId ?? this.bpId,
      location: location ?? this.location,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (bpId != null) {
      result.addAll({'bpId': bpId});
    }
    if (location != null) {
      result.addAll({'location': location});
    }
    if (time != null) {
      result.addAll(
          {'time': CustomDateUtils.dateTimeInIsoFormatWithoutZone(time!)});
    }

    return result;
  }

  factory BusPoint.fromMap(Map<String, dynamic> map) {
    return BusPoint(
      bpId: map['bpId'],
      location: map['location'],
      time: map['time'] != null ? DateTime.tryParse(map['time']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusPoint.fromJson(String source) =>
      BusPoint.fromMap(json.decode(source));

  @override
  String toString() =>
      'BusPoint(bpId: $bpId, location: $location, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusPoint &&
        other.bpId == bpId &&
        other.location == location &&
        other.time == time;
  }

  @override
  int get hashCode => bpId.hashCode ^ location.hashCode ^ time.hashCode;
}
```

Rules:
- All members present, in this order: fields, constructor, `copyWith`, `toMap`, `fromMap`, `toJson`, `fromJson`, `toString`, `==`, `hashCode`. Fields are `final`. Do not add `json_serializable` / `freezed`.
- JSON keys are the backend's keys, verbatim. `toMap` omits null fields with `if (x != null) { result.addAll({'x': x}); }`.
- `fromMap`: primitives `map['x']` (required strings `?? ''`); numbers `map['x']?.toInt()` / `?.toDouble()`; nested `map['x'] != null ? X.fromMap(map['x']) : null`; lists `List<X>.from(map['xs']?.map((x) => X.fromMap(x)))`; list equality uses `listEquals` from `package:flutter/foundation.dart`.
- Enums: `stringToEnum(map['x'], X.values)` / `X.fromCode(...)`; write back with `.code` / `.value`.
- Dates: `DateTimeParser.tryParseFromMap(map, 'key')` (keeps wall-clock time, ignores the offset) is used in flight itinerary / passenger models (12 files), `passenger_detail_form_cubit` and `hotel_search_request.dart`. `DateTime.tryParse` is used in bus, trip, auth, flight `order_status.dart` timestamps and `hotel_order_item.dart`. Copy the sibling model in the same folder; with no sibling, ask the owner. Serialise with `CustomDateUtils`.
- A field that `copyWith` must be able to reset to null uses `Nullable<T>`: `copyWith({Nullable<DateTime>? returnDate})` -> `returnDate == null ? this.returnDate : returnDate.value`.

---

## 7. Domain layer

### 7.1 Repository interface
`abstract interface class <Name>Repository` in `domain/repositories/`, same method signatures as the service (6.3).

### 7.2 Use case
```dart
// features/thing/domain/usecases/thing_usecase.dart
abstract interface class ThingUseCase {
  Future<List<ThingResponse>> getThings(String userId);
}

class ThingUseCaseImpl implements ThingUseCase {
  final _thingRepository = getIt<ThingRepository>();

  @override
  Future<List<ThingResponse>> getThings(String userId) async {
    return await _thingRepository.getThings(userId);
  }
}
```
Interface and Impl share one file (trip splits them: do not copy). Older names deviate (`auth_use_case.dart`: `AuthUseCase` + interface `IAuthUseCase`; `hotel_book_use_case.dart`; `bus_repo_impl.dart`, `auth_repo_impl.dart`); new code uses `<name>_usecase.dart` and `<name>_repository_impl.dart`. Mapping from UI entity to request model happens in the use case via the mapper (`BusUseCaseImpl.getBusSearchResponse` calls `BusMapperUtility.mapBusSearchToBusSearchRequest`). A use case may hold another feature's use case (section 14).

### 7.3 Mapper utility
`class XMapperUtility { XMapperUtility._(); static Request mapX(Entity e) {...} }`. Pure functions, no `getIt`, no UI. Validation that needs a user-visible failure throws `Exception("...")`.

### 7.4 Entities, enums, extensions
UI-facing classes (search params, selections) follow the model style of 6.4 (`copyWith`, `toMap` / `fromMap` for recent-search persistence, `==` / `hashCode`). Enums and extensions on models live in `domain/entities/`. Derived display helpers on a model go in an extension (`UserBookingProfileExtension.displayName`), not in the widget.

---

## 8. Dependency injection

```dart
// lib/dependncy_injection.dart, inside setupDependencyInjection(), grouped by feature
//THING
getIt.registerLazySingleton<ThingService>(() => ThingServiceImpl());
getIt.registerLazySingleton<ThingRepository>(() => ThingRepositoryImpl());
getIt.registerLazySingleton<ThingUseCase>(() => ThingUseCaseImpl());
```
- Order per feature: service, (local service), repository, use case. Always the abstract type as generic argument.
- Consumers: `final _thingUseCase = getIt<ThingUseCase>();` as a field initialiser in Cubits (and use cases / repositories). `getIt` is exported through `package:yellow_rose/dependncy_injection.dart`.
- Cubits are created with `BlocProvider(create: ...)`, never registered in GetIt.

---

## 9. State management

### 9.1 Async flow (load / search / book): sealed state for new Cubits (global Auth / Trip / HomeScreen / AppUpdate and BusDetail states are `abstract class`: older style)

```dart
// presentation/cubit/thing_listing/thing_listing_cubit.dart
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/thing/data/models/thing_response.dart';
import 'package:yellow_rose/features/thing/domain/usecases/thing_usecase.dart';

part 'thing_listing_state.dart';

class ThingListingCubit extends Cubit<ThingListingState> {
  ThingListingCubit() : super(ThingListingInitial());

  final _thingUseCase = getIt<ThingUseCase>();

  void loadThings(String userId) async {
    try {
      emit(ThingListingLoading());
      var things = await _thingUseCase.getThings(userId);
      emit(ThingListingLoaded(things: things));
    } catch (e, s) {
      log("$e $s");
      emit(ThingListingError(e.toString()));
    }
  }

  void onSelectThing(ThingResponse thing) {
    if (state is ThingListingLoaded) {
      emit((state as ThingListingLoaded).copyWith(selected: thing));
    }
  }
}
```

```dart
// presentation/cubit/thing_listing/thing_listing_state.dart
part of 'thing_listing_cubit.dart';

sealed class ThingListingState extends Equatable {
  const ThingListingState();

  @override
  List<Object?> get props => [];
}

final class ThingListingInitial extends ThingListingState {}

final class ThingListingLoading extends ThingListingState {}

final class ThingListingLoaded extends ThingListingState {
  final List<ThingResponse> things;
  final ThingResponse? selected;

  const ThingListingLoaded({required this.things, this.selected});

  ThingListingLoaded copyWith({
    List<ThingResponse>? things,
    ThingResponse? selected,
  }) {
    return ThingListingLoaded(
      things: things ?? this.things,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [things, selected];
}

final class ThingListingError extends ThingListingState {
  final String errorMessage;

  const ThingListingError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
```

### 9.2 Form / search state: single class

```dart
part of 'thing_search_cubit.dart';

class ThingSearchState extends Equatable {
  final String? source;
  final DateTime? dateOfJourney;
  final String? error;
  final bool isLoading;

  const ThingSearchState({
    this.source,
    this.dateOfJourney,
    this.error,
    this.isLoading = true,
  });

  factory ThingSearchState.initial() {
    return ThingSearchState(
      dateOfJourney: DateTime.now().add(const Duration(days: 1)),
    );
  }

  ThingSearchState copyWith({
    String? source,
    DateTime? dateOfJourney,
    String? error,
    bool? isLoading,
  }) {
    return ThingSearchState(
      source: source ?? this.source,
      dateOfJourney: dateOfJourney ?? this.dateOfJourney,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [source, dateOfJourney, error, isLoading];
}
```
Form Cubits expose `onXChange(value) => emit(state.copyWith(x: value))` methods (`SignInFormCubit`, `BusSearchCubit`).

### 9.3 Rules
- Cubit file imports `bloc` + `equatable`, declares `part '<x>_state.dart';`; the state file starts with `part of '<x>_cubit.dart';` and has no imports of its own.
- Catch pattern for new code (about half of existing catches omit `s`): `catch (e, s) { log("$e $s"); emit(XError(e.toString())); }`. Methods the UI awaits return `Future<void>` and `rethrow` after logging; fire-and-forget loaders are `void loadX() async`.
- Never mutate a list / map held in state: copy first (`[...state.x]`, `Map.from`), then `emit(copyWith(...))`. `props` lists every field.
- Branch on state with `if (state is XLoaded)` and cast `(state as XLoaded)`.
- Where Cubits are created:
  - Route level in `AppRouter`, for screens with arguments: `BlocProvider(create: (context) => XCubit(arg)..loadX(arg), child: ...)`.
  - Inside the screen `build` with `BlocProvider(create:)`, for sheet screens and search screens that own a form Cubit.
  - Shared across a multi-screen flow: create once, pass in `arguments: {'cubit': context.read<XCubit>()}`, receive with `BlocProvider.value`.
  - Global (only `AuthCubit`, `TripCubit`, `HomeScreenCubit`, `AppUpdateCubit`, in `main.dart`). Reach them anywhere with `context.read<...>()`. `AuthCubit.state` can be `AuthInitial`: use its getters (`tripType`, `allProfiles`, `enabledServices`) instead of casting.
- Prefer `BlocBuilder` for rendering and `BlocListener` for side effects (snackbar / pop). Do not use `BlocConsumer`, `context.watch` or `BlocSelector` (one stray use each of the first two, none of the third).
- Local ephemeral state: `setState` inside a `StatefulWidget`, or `ValueNotifier` + `ValueListenableBuilder` for a single flag (loader overlay, search query). Dispose controllers and notifiers in `dispose()`.

---

## 10. Presentation

### 10.1 List / search screen skeleton

```dart
class ThingSearchListScreen extends StatelessWidget {
  static const String routeName = "/thingSearchListScreen";

  const ThingSearchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Things",
        subTitle: "",
        shouldHaveRadius: false,
      ),
      bottomNavigationBar: BlocBuilder<ThingListingCubit, ThingListingState>(
        builder: (context, state) {
          if (state is ThingListingLoaded && state.selected != null) {
            return SizedBox(
              height: 95.h,
              child: BottomButton(
                buttonText: "Book Now",
                title: "₹ ${state.selected!.price.toStringAsFixed(0)}",
                subtitle: "TOTAL COST",
                onClick: () {
                  Navigator.of(context).pushNamed(
                    ThingDetailScreen.routeName,
                    arguments: {'thing': state.selected},
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocListener<ThingListingCubit, ThingListingState>(
        listener: (context, state) {
          if (state is ThingListingError) {
            Navigator.of(context).pop();
            WidgetUtil.showSnackBar("Error, please try again", context);
          }
        },
        child: BlocBuilder<ThingListingCubit, ThingListingState>(
          builder: (context, state) {
            if (state is ThingListingLoaded) {
              if (state.things.isEmpty) {
                return Center(
                  child: Text(
                    "No Things Found",
                    style: TextStyles.bodyLargeBoldStyle(),
                  ),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: state.things.length,
                itemBuilder: (ctx, idx) => ThingResultCard(
                  thing: state.things[idx],
                  onTap: () => context
                      .read<ThingListingCubit>()
                      .onSelectThing(state.things[idx]),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
              );
            }
            return const Loader();
          },
        ),
      ),
    );
  }
}
```

### 10.2 Booking form screen skeleton (sticky bottom bar + loader overlay)

```dart
class ThingBookFormScreen extends StatelessWidget {
  static const routeName = "/thingBookFormScreen";

  const ThingBookFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loader = ValueNotifier(false);

    return ValueListenableBuilder(
      valueListenable: loader,
      builder: (context, loading, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: BaseAppBar(
                title: 'Thing Booking',
                subTitle: '',
                shouldHaveRadius: false,
              ),
              bottomNavigationBar: BlocBuilder<ThingBookCubit, ThingBookState>(
                builder: (context, state) {
                  if (state is ThingBookLoaded) {
                    return SizedBox(
                      height: 95.h,
                      width: double.infinity,
                      child: BottomButton(
                        buttonText: "Book",
                        title: "₹ ${state.total.toStringAsFixed(1)}",
                        subtitle: "Total Cost",
                        onClick: () async {
                          if (state.billingEntity == null) {
                            WidgetUtil.showSnackBar(
                                "Please select billing entity", context);
                            return;
                          }
                          final cubit = context.read<ThingBookCubit>();
                          final navigator = Navigator.of(context);
                          loader.value = true;
                          try {
                            await cubit.updateOrder();
                            navigator.pushNamed(
                              ThingReviewScreen.routeName,
                              arguments: {"cubit": cubit},
                            );
                          } catch (e, s) {
                            log("$e $s");
                            if (context.mounted) {
                              WidgetUtil.showSnackBar(
                                  "Error updating details, try again!",
                                  context);
                            }
                          }
                          loader.value = false;
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              body: BlocBuilder<ThingBookCubit, ThingBookState>(
                builder: (context, state) {
                  if (state is ThingBookLoaded) {
                    return SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(height: 16.h),
                            // TravelerDetailsWidget, billing entity field ...
                            SizedBox(height: 150.h),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Loader();
                },
              ),
            ),
            if (loading) const Loader(),
          ],
        );
      },
    );
  }
}
```
`final loader = ValueNotifier(false);` inside `build` is the existing pattern of `bus_book_form_screen` and `hotel_book_form_screen`; use it only for this loader overlay. Anything that owns controllers or animations is a `StatefulWidget` with `dispose()` (9.3).

Every booking flow (flight, hotel, bus) also includes: `TravelerDetailsWidget` with `isReadOnly` / `lockMessage` from `TripValidationHelper.shouldDisablePassengerControls(context.read<TripCubit>().selectedTrip)`, a billing-entity `LabeledDropDownField`, and the trip / payment handling in section 14.

### 10.3 Bottom-sheet screens

- Open with `WidgetUtil.showBottomSheet(context, XScreen(...))`; it already wraps the body in a scroll view and keyboard padding. Tall sheets: `SizedBox(height: MediaQuery.of(context).size.height * .85, ...)`.
- Header: `BottomSheetTitleWidget(title: "Filter")`. Footer action: `Align(alignment: Alignment.bottomCenter, child: SizedBox(width: double.infinity, height: 95.h, child: BottomButton(title: "", buttonText: "Apply", onClick: () => Navigator.of(context).pop(state))))` and a trailing `SizedBox(height: 120.h)` in the scrolling content.
- Return a value with `Navigator.of(context).pop(value)`; the caller does `final result = await WidgetUtil.showBottomSheet(...); if (result != null && result is X) {...}`.
- Selectable options are `PillButton`s inside `Wrap(spacing: 10.h, runSpacing: 16.h)`, `PillType.primary` when selected, `PillType.secondary` otherwise. A sheet that owns UI state creates its own Cubit with `BlocProvider(create:)`.
- Dates: `WidgetUtil.showBottomSheet(context, DatePicker(isRangePicker: false, startDate: ...))` returns a `List<DateTime>?`.

### 10.4 Navigation and routes

```dart
// 1. screen
static const String routeName = "/thingSearchListScreen";

// 2. lib/app_routes.dart, inside onGenerateRoute
case ThingSearchListScreen.routeName:
  var args = settings.arguments as Map?;
  if (args?['thingSearch'] != null) {
    var thingSearch = args!["thingSearch"] as ThingSearch;

    return MaterialPageRoute(
      settings: RouteSettings(
          name: formatScreenName((ThingSearchListScreen).toString())),
      builder: (_) => BlocProvider(
        create: (context) =>
            ThingListingCubit(thingSearch)..searchThings(thingSearch),
        child: const ThingSearchListScreen(),
      ),
    );
  }

// shared Cubit from the previous screen
case ThingReviewScreen.routeName:
  var args = settings.arguments as Map?;
  if (args?["cubit"] == null) break;
  return MaterialPageRoute(
    settings: RouteSettings(
        name: formatScreenName((ThingReviewScreen).toString())),
    builder: (_) => BlocProvider.value(
      value: args!["cubit"] as ThingBookCubit,
      child: const ThingReviewScreen(),
    ),
  );

// 3. caller
Navigator.of(context).pushNamed(
  ThingSearchListScreen.routeName,
  arguments: {'thingSearch': search},
);
```
- Bottom-sheet screens (pickers, filters, `OrderStatusScreen` via `returnToHomeScreen`) have no `routeName` and no route entry. Route-name outliers (`'/trip-home'`, `'/trip-detail'`, `"/eTicektScreen"`, `"/flightAddonScreen"`, `"/homeScreen"` for `Dashboard`, `"/HotelSearchScreen"`) are legacy: never rename, never imitate.
- Always push with the `routeName` constant, never a string literal (one constant is spelled `"/HotelSearchScreen"`). Arguments are a `Map` with camelCase string keys; the Cubit instance travels under `'cubit'`.
- No `Navigator.push(MaterialPageRoute(...))` in screens (legacy exceptions exist in 16.4). The end of a booking / payment flow calls `WidgetUtil.returnToHomeScreen(context, orderStatus, tripType)`.
- Use `RouteSettings(name: formatScreenName((X).toString()))` exactly as the other cases do (copy the right class into it; a few legacy cases name the wrong class).

### 10.5 Forms

- `Form(key: _formKey, autovalidateMode: AutovalidateMode.onUserInteraction, child: ...)`; submit with `if (_formKey.currentState!.validate()) {...}`.
- Field = label + input: `TitleFormWidget(text: 'Trip Name *', child: CustomTextFormField(cont: _ctrl, text: 'Trip Name', validator: ...))`, or `FormTitle(title: "Email")` followed by the field. Dropdowns: `CustomDropDownField(hint:, val:, data:, onchange:, validator:)`.
- Validator messages: `Please enter <field>`, `Please enter a valid <field>`, `<Field> is required`, `Please select <field>`. Email regex is `Utils.emailRegex`.
- Submit button: `CustomButton(buttonController: _btnController, text: "Create Trip", onPressed: ...)` with `_btnController.start()`, then `successReset()` / `errorReset()`; failure also shows a snackbar.
- Own the `TextEditingController`s / `GlobalKey`s in a `State` and dispose them. Config-driven forms use `FormFieldConfig` (see `AddUpdatePassengerDetailsScreen`).

### 10.6 Loading, empty and error states

- Loading: `const Loader()` as the body fallback (`return const Loader();` after the `Loaded` branch), or `if (loading) const Loader()` in a `Stack`.
- Empty list: `Center(child: Text("No Things Found", style: TextStyles.bodyLargeBoldStyle()))`.
- Richer empty / error block (trip screens): centred `Column` with `Icon(Icons.luggage_outlined / Icons.error_outline, size: 64.h, color: AppColors.primaryTextSwatch[300])`, `SizedBox(height: 16.h)`, title `bodyLargeBoldStyle`, `SizedBox(height: 8.h)`, subtitle `bodyMediumMediumStyle` + `primaryTextSwatch[500]` centred, `SizedBox(height: 24.h)`, optional `CustomButton(text: 'Retry')`. Error text: "Unable to load X" / "Please try again".
- Load failure on a pushed screen: `BlocListener` does `Navigator.of(context).pop()` then a snackbar. Pull-to-refresh with `RefreshIndicator` on server-paged lists.

### 10.7 Dialogs, snackbars, sheets

```dart
WidgetUtil.showSnackBar("Please select billing entity", context);                       // error, red by default
WidgetUtil.showSnackBar("Cart ID copied!", context, col: AppColors.primaryGreen);       // success / info

WidgetUtil.showPopup(
  context,
  icon: Image.asset("assets/images/cacel_icon.png", height: 40.h),
  title: "Are you sure you want to cancel your Bus booking?",
  buttons: [
    PopupButton(text: "No", type: PopupButtonType.secondary, onPressed: () {}),
    PopupButton(
        text: "Yes",
        onPressed: () async {
          await context.read<BusOrderModifyCubit>().onCancel();
        }),
  ],
);
```
Destructive actions always confirm with "No" (secondary) / "Yes" (primary). A `PopupButton` closes the dialog before running `onPressed` unless `autoClose: false`.

### 10.8 Widget composition

- Pass data in through `final` constructor fields; callbacks as `VoidCallback? onTap` / `Function(T) onX`.
- Inside a `State` class use `_buildX()` methods for sections (`TripHomeScreen`). In a `StatelessWidget` screen, big sections become private widget classes in the same file (`_Tag`, `_EmptySection`). Anything reused moves to its own file under `widgets/` (or `core/common_widgets/`).
- Selected / unselected cards: border `AppColors.primary` vs `AppColors.primaryTextSwatch[200]!`, fill `AppColors.primarySuccessSwatch[200]` vs `Colors.white`.
- Card recipe (from `BusSearchResultCard`):

```dart
class ThingResultCard extends StatelessWidget {
  final ThingResponse thing;
  final bool isSelected;
  final VoidCallback? onTap;

  const ThingResultCard({
    super.key,
    required this.thing,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySuccessSwatch[200] : Colors.white,
          borderRadius: BorderRadius.circular(12.h),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.primaryTextSwatch[200]!,
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(thing.name ?? '', style: TextStyles.bodyLargeBoldStyle()),
              SizedBox(height: 12.h),
              Text(
                thing.subtitle ?? '',
                style: TextStyles.bodySmallMediumStyle()
                    .copyWith(color: AppColors.primaryTextSwatch[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 10.9 Gotchas

- `.h` / `.w` are not compile-time constants: remove `const` from every enclosing widget that uses them.
- `AppColors.primaryTextSwatch[N]` / `primarySwatch[N]` return `Color?`: add `!` where a non-null `Color` is required (`BorderSide`, `BoxShadow`); omit it for nullable parameters (`copyWith(color:)`, `Container.color`).
- `TextStyles.bodySmallStyle()` is a method: call it.
- `CustomTextFormField.type` defaults to the email keyboard: always pass `type:` for other inputs. Its built-in vertical margin is 7.
- `BaseAppBar` is not `const` (mutable fields). `shouldHaveRadius` defaults to `true`; pushed screens pass `false`.
- `BottomButton` has no height of its own: wrap in `SizedBox(height: 95.h, ...)`.
- `WidgetUtil.showSnackBar` takes `(message, context)`; message first.
- After the last item of a scroll view that sits above a bottom bar, leave `SizedBox(height: 150.h)`.
- `getIt` is only valid after `setupDependencyInjection()` (done in `main`).

---

## 11. UI system

### 11.1 Sizing
- `SizeConfig` assumes a 393 x 852 design canvas. `N.h` = `N / 8.52 * screenHeight / 100`; `N.w` = `N / 3.93 * screenWidth / 100`. Extensions exist on `int` and `double` (`16.h`, `16.5.w`).
- Vertical gap / height / vertical padding: `.h`. Horizontal gap / width / horizontal padding: `.w`. Icon sizes, radii, avatar radii: `.h`. Font sizes live only in `TextStyles` (already `.h`).
- Padding forms: `EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)`, `EdgeInsets.all(16.w)` for cards, `EdgeInsets.only(top: 12.h)`.
- Allowed raw numbers: `0`, hairline border widths (`1`, `0.5`), `double.infinity`, flex / aspect ratios, opacity / alpha, durations, `maxLines`, counts, spinner `strokeWidth`, screen-fraction heights for sheets (`MediaQuery.of(context).size.height * .85`).
- Shadow blur / offset use `.w` / `.h` in new code (`blurRadius: 10.w, offset: Offset(0, 4.h)`).

### 11.2 Spacing scale
Use values from {2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 30, 32, 40}.

| Use | Value |
|---|---|
| Title / subtitle lines | `2.h` - `4.h` |
| Icon-to-text, inline gap | `4.w` - `8.w`, `12.w` for avatars |
| Standard small gap | `8.h` / `8.w` |
| Between rows in a card | `12.h` |
| Between blocks | `16.h` |
| Between sections | `24.h` |
| Card inner padding | `EdgeInsets.all(16.w)` (compact `12`) |
| Screen horizontal padding | `16.w` for lists and booking forms; `24.w` for search, sign-in and sheet forms |
| Bottom action bar | `95.h` |
| Space under last form item above a bottom bar | `150.h` |
| Blue backdrop block behind search cards | `150.h` - `160.h` |

### 11.3 Radii, borders, shadows
- Radii: 8 (tiles, banners, small controls), 10 (inputs, bordered containers), 12 (cards), 16 (large cards), 24 (pills, sheet top). Written as `BorderRadius.circular(12.h)`.
- Borders: 1 px. Neutral `AppColors.primaryTextSwatch[200]!`, blue-tinted `AppColors.primarySwatch[200]!`, selected `AppColors.primary`.
- Soft card shadow: `BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 10.w, offset: Offset(0, 4.h))`. Bottom bar shadow: `Colors.black.withOpacity(0.05)`, blur 10, offset `(0, -2)`. Elevation 0 on cards.
- Opacity is written `.withOpacity(x)` (repo standard; do not introduce `.withValues`).

### 11.4 Colour
| Token | Value | Use |
|---|---|---|
| `AppColors.primary` | `0xFF1F48AA` | Brand blue: AppBar, primary buttons, selected borders, prices, section headers |
| `AppColors.primaryText` | `0xFF111827` | Default text colour (baked into every `TextStyles`) |
| `AppColors.primaryTextSwatch[50..900]` | greys | 50 light fill, 100 light divider / secondary button, 200 borders, 300 empty-state icons, 400 hint / disabled, 500 secondary text, 600 labels / meta, 700 strong labels |
| `AppColors.primarySwatch[50..900]` | blue tints | 50 light fill, 100 bottom-bar background, 200 borders, 300 / 400 accents (dashed lines) |
| `AppColors.primaryGreen` | `0xFF12A58C` | Success, traveller avatars, success snackbars (`col:`) |
| `AppColors.primarySuccessSwatch[..]` | green tints | Selected card background (200) |
| `AppColors.error`, `errorSwatch` | `0xFFF6285F` | Errors, destructive, default snackbar colour |
| `AppColors.warning` | `0xFFFFDF6E` | Warnings (rare) |
| `disabledButton`, `secondaryButton`, `icon`, `containerBackground`, `outlineColor` | | Consumed by `AppTheme`; rarely used directly |

`Colors.white` (surfaces, text on blue), `Colors.transparent`, and `Colors.black` with opacity (shadows / scrims) are the only `Colors.*` allowed. Existing semantic status colours (`Colors.green / orange / red` in `CustomBanner`, `ChipButton`, `TripCard`) are legacy: do not extend them to new widgets; add an `AppColors` token instead.

### 11.5 Typography
All styles are `TextStyles.<name>Style()` in `core/theme/text_styles.dart`, font `Roboto` (set only there), default colour `primaryText`.

| Family | Size (design px) | Variants |
|---|---|---|
| `h1Style` .. `h6Style` | 48, 40, 28, 24, 20, 16 | bold only |
| `bodyXLarge` | 18 | plain, `Bold`, `SemiBold`, `Medium` |
| `bodyLarge` | 16 | plain, `Bold`, `SemiBold`, `Medium` |
| `bodyMedium` | 14 | plain, `Bold`, `SemiBold`, `Medium` |
| `bodySmall` | 12 | plain, `Bold`, `SemiBold`, `Medium` |

Variant naming: `bodyMediumSemiBoldStyle()`. Observed roles:
- Secondary / meta text: `bodySmallMediumStyle()` or `bodySmallStyle()` + `.copyWith(color: AppColors.primaryTextSwatch[500])` (or `[600]`). Most used.
- Body emphasis: `bodyMediumSemiBoldStyle()`, `bodyMediumBoldStyle()` (button text).
- Card / headline title: `bodyLargeBoldStyle()`, `bodyLargeSemiBoldStyle()`.
- Section header on a tinted container: `h6Style().copyWith(color: AppColors.primary)`.
- Price: `bodyXLargeBoldStyle().copyWith(color: AppColors.primary)`.
- App bar title: from theme (`h6`, white) or `bodyXLargeBoldStyle().copyWith(color: Colors.white)`.
- `h1`, `h2`, `h3` and plain `bodyXLarge` are unused; do not reach for them without a design reason.

### 11.6 Icons, assets, images
- Material `Icons.*`, outlined / rounded variants (`Icons.info_outline`, `Icons.arrow_forward_ios_rounded`). Sizes `16.h` (inline), `20.h`, `24.h`, `64.h` (empty state). Colour `AppColors.primary` or `primaryTextSwatch[N]`.
- Asset icons: `ImageIcon(const AssetImage("assets/images/icons/air.png"), size: 17.h)`. Circular asset icon: `CustomImageIcon`. Declared asset folders: `assets/images/`, `assets/images/icons/`, `assets/images/bus_seats/`; a new folder needs a `pubspec.yaml` edit (ask).
- Network images: `CachedNetworkImage` with a placeholder and an error fallback icon (section 16.5 lists this as an extraction candidate; create the common widget before adding another copy).

### 11.7 Motion
Durations 200 - 400 ms with `Curves.easeInOut` (`PageController.animateToPage`, `AnimatedCrossFade`). Default `MaterialPageRoute` transitions.

### 11.8 UX conventions
- Pushed screens: `Scaffold` + `BaseAppBar(title:, subTitle: "", shouldHaveRadius: false)`; dashboard tabs keep the default radius.
- Search and list screens: the main card sits over a blue backdrop `Container(height: 150.h, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))))` in a `Stack`.
- A screen's primary action lives in a sticky `BottomButton` (`bottomNavigationBar`), not at the end of the scroll content. Exceptions: sign-in, bottom-sheet forms (`CustomButton` at the end), retry buttons.
- Filters: `FloatingActionButton(child: Icon(Icons.filter_alt_outlined))` -> `WidgetUtil.showBottomSheet` filter sheet. Pickers (city, airport, date, traveller, payment method) are bottom sheets.
- Selection = `PillButton`; read-only selector fields = `LabeledInfoWidget` wrapped in `InkWell`.
- Errors: red snackbar; field errors inline via `validator`; flow-level validation (missing billing entity / travellers) via snackbar.
- Long operations: screen-level `ValueNotifier<bool>` + `Loader` overlay; button-level `CustomButton(buttonController:)`.

---

## 12. Reuse catalog (check here before writing any UI or helper)

`*` = required parameter. All file paths below are under `lib/core/` unless noted.

### 12.1 Common widgets (`common_widgets/`)

| Widget (file) | Parameters | Use for |
|---|---|---|
| `CustomButton` (`button.dart`) | `text*`, `onPressed`, `buttonType` (`ButtonType.primary` / `secondary`), `buttonController` (`RoundedLoadingButtonController`; extension `successReset()` / `errorReset()`) | Every filled action button |
| `CustomOutlinedButton` (`custom_outline_button.dart`) | `text*`, `onPressed`, `buttonType` (`OutlinedButtonType.primary` / `danger` / `secondary`), `textStyleOverride` | Outlined and destructive buttons |
| `BottomButton` (`bottom_button.dart`) | `title*`, `subtitle`, `buttonText*`, `onClick*` | Sticky bar: price block + CTA. Pass `title: ""` for CTA only |
| `PillButton` (`pill_button.dart`) | `text` or `child`, `pillType` (`PillType.primary` = selected / `secondary`), `onClick`, `borderColor` | Toggle, filter, segment options |
| `ChipButton` (`chip_button.dart`) | `text*`, `chipType` (`ChipType.primary` / `secondary` / `success` / `warning` / `error`), `leadingIcon`, `onRemove`, `onTap` | Removable tags |
| `ImageIconButton` (`image_icon_button.dart`) | `image*`, `title*`, `onClick`, `size`, `radius`, `color`, `backgroundColor` | Round icon with caption (home tiles) |
| `IncrementBoxWidget` (`increment_box.dart`) | `initialValue`, `onValueChange`, `minValue`, `maxValue`, `enabled` | Stepper |
| `IncrementBoxPaxWidget` (`increment_box_pax_widget.dart`) | `title*`, `subtitle*`, `onChange*`, `initialValue`, `minValue`, `maxValue`, `enabled` | Passenger count row |
| `Pill` (`pill.dart`) | `child*`, `backgroundColor` | Small rounded label |
| `CustomBanner` (`custom_banner.dart`) | `message*`, `type` (`BannerType.info` / `warning` / `error` / `success` / `custom`), `icon`, `trailing`, `onTap`, `showIcon`, `showBorder`, colour / padding overrides, `customContent` | Inline info / warning / error banners |
| `KeyValueRow` (`key_value_row.dart`) | `label*`, `value*`, `emphasised`, `valueAlign`, `valueColor` | Fare and detail rows |
| `LabeledInfoWidget` (`labeled_info_widget.dart`) | `title*`, `content*`, `leading`, `onCLick`, `body` | Boxed read-only field (From / To / Date) |
| `CustomListTile` (`custom_list_tile.dart`) | `title*`, `subtitle`, `trailing` (all `Widget`) | Two-sided row |
| `GstInfoCard` (`gst_info_card.dart`) | `billingEntity*`, `initiallyExpanded`, `title`, `collapsedMessage` | Billing / GST summary |
| `CustomImageIcon` (`ImageIcon.dart`) | `image*`, `size`, `radius`, `color`, `backgroundColor` | Circular asset icon |
| `FullScreenImageCarousel` (`image_carousel.dart`) | `FullScreenImageCarousel.show(context, imageUrls:, initialIndex:)` | Full-screen gallery |
| `Loader` (`loader.dart`) | `color` (default `Colors.black26`) | All loading states |
| `FlexSwitch` (`flex_switch.dart`) | `isRow*`, `children*`, alignment params | Row / Column toggle |
| `SelectedUserTags` (`selected_user_tags.dart`) | `selectedUsers*`, `onRemove*` | Chips for chosen profiles |
| `CustomTextFormField` (`custom_text_form_field.dart`) | `text` (hint), `icon` (prefix `IconData`), `suffixicon`, `cont`, `initvalue`, `validator`, `onchange`, `onsave`, `onFieldSubmitted`, `type`, `maxlenght`, `maxLines`, `formatters`, `obs`, `enabled`, `fillColor`, `helperText`, `errorText`, `showBorder`, `showColoredDisabled` | Every text input |
| `CustomDropDownField` (`cutom_dropdown_field.dart`) | `data` (`List<String>`) or `data1` (items), `hint`, `val`, `onchange`, `onSaved`, `validator`, `isEnabled`, `showBorder`, `fillColor`, `textStyle` | Dropdowns |
| `TitleFormWidget` (`title_form_widget.dart`) | `text*`, `child*` | Label above a field (adds 14.h top margin) |
| `FormTitle` (`form_title_widget.dart`) | `title*` | Standalone field label |
| `LabeledContainerField` (`labelled_container.dart`) | `label*`, `child` | Titled block in a bordered container |
| `LabeledDropDownField` (`labelled_drop_dowdn.dart`) | `label*`, `items*`, `onChanged*`, `selectedValue` | Labelled dropdown (billing entity) |
| `DatePicker` (`date_picker.dart`) | `isRangePicker`, `startDate`, `endDate`, `minDate`, `requireBothStartAndEndDates` | Calendar sheet; pops `List<DateTime>` |
| `CustomOverlayDropdown` (`custom_overlay_dropdownd.dart`) | `title*`, `items*`, `maxHeight`, `verticalGap` | Overlay dropdown |
| `FormFieldConfig`, `FieldType` (`utils/form_filed_config.dart`) | `type*`, `title*`, `onChange*`, `values`, `validator`, `value`, `maxLength`, `textInputType`, `formatters` | Config-driven forms |
| `BaseAppBar` (`base_appbar.dart`) | `title*`, `subTitle`, `actionsCustom`, `bottom`, `height`, `titleStyle`, `shouldHaveRadius`, `onAppBarClick` | AppBar of every screen |
| `BottomSheetTitleWidget` (`bottom_sheet_title_widget.dart`) | `title*`, `onCloseClick` | Header of every sheet screen |
| `RoundedTabBars` (`rounded_tab_bar.dart`) | `onTap*`, `children` or `tabChildrens`, `type` (`RoundedTabBarType.primary` / `secondary`), `isScrollable`, `tabBarHeight`, `tabController`, `borderRadius`, `textStyle` | Pill tabs over the blue header |
| `DefaultTabControllerListener` (`default_tab_controller_listner.dart`) | `onTabChanged*`, `child*` | React to `DefaultTabController` |
| `PopupDialog`, `PopupButton` (`popup.dart`) | via `WidgetUtil.showPopup` only | Confirm / info dialogs |
| `TravelerDetailsWidget` (`passenger_detail/traveller_details_widget.dart`) | `maxAdult*`, `maxChild`, `maxInfant`, `passengerDetails*`, `onAddUpdate*`, `savedProfiles`, `showAge`, `isReadOnly`, `lockMessage` | Traveller list / editor on booking forms |
| `AddUpdatePassengerDetailsScreen` (`passenger_detail/`) | `passengerType*`, `passengerDetailsEntity` | Sheet; pops `PassengerDetailsEntity` |
| `SearchableTravelerDropdown` (`passenger_detail/`) | `profiles*`, `onAddNew*`, `mode` (`SelectionMode.passenger` / `profile`), `onSelected`, `onProfileSelected`, `passengerType`, `multiSelect`, `maxSelections`, `excludeProfileIds` | Saved-profile picker |

### 12.2 `WidgetUtil` (`utils/WidgetUtils.dart`)

| Method | Signature | Use |
|---|---|---|
| `showSnackBar` | `(String message, BuildContext context, {Color col = AppColors.error, int milliseconds = 2000, bool persist = false})` | Every toast |
| `showBottomSheet` | `(BuildContext, Widget body, {bool isDismissible = true, double radius = 24, double? maxHeight})` returns the popped value | Every sheet, picker, filter |
| `showWrapContentBottomSheet<T>` | `({required context, required child, maxHeightFraction = 0.8, isDismissible, borderRadius, backgroundColor})` | Content-height sheet |
| `showPopup<T>` | `(context, {icon, title, message, content, buttons, ...})` | Confirm / info dialog |
| `showDialog<T>` | `(context, Widget body, {width, height, barrierDismissible, barrierColor})` | Custom animated dialog (`showPopup` wraps it) |
| `showUpdateBottomSheet` | `(context, {shouldForceUpdate, description})` | App-update prompt only |
| `returnToHomeScreen` | `(context, OrderStatusEnum, TripType)` | End of booking / payment flow |

### 12.3 Utilities

| Name (file) | Contents |
|---|---|
| `CustomDateUtils` (`utils/date_utils.dart`) | Display: `givenFormat(d, "dd MMM yyyy")` (most used), `timeIn24`, `timeInAmPm`, `dayDateMonthFormat`, `dayMonthYearFormat`, `dayMonthFormat`, `fullDayFormat`, `durationToString(minutes)`. API: `customApiDayFormat` (yyyy-MM-dd), `apiDayFormat`, `dateTimeInIsoFormatWithoutZone`. Calendar: `isSameDay`, `addMonths`, `daysInMonth`, `calculateAge`. Add a new format here, never inline |
| `DateTimeParser` (`utils/date_time_parser.dart`) | `tryParseFromMap(map, key)`, `parseFromMap`, `tryParse`, `parse`, `calculateAge`; keeps wall-clock time, ignores offsets |
| Extensions (`utils/extensions.dart`) | `String.toEnum(values)`, `stringToEnum(value, values)`, `toTitleCase()`, `equalsIgnoreCase()` |
| `Utils` (`utils/common_utils.dart`) | `emailRegex`, `launchMap(lat, lng)` |
| `Nullable<T>` (`nullable.dart`) | Null-settable `copyWith` wrapper |
| `DioClient` (`utils/dio_client.dart`) | `get` / `post` / `put` / `delete`; used by services only |
| `AppConfig` (`app_config.dart`) | `AppConfig.instance.apiBaseUrl`, `googleApiKey`, `currentStage` |
| `SharedPreferencesRepository` (`utils/shared_pref_repository.dart`) | Static `putX` / `getX` (Integer, Double, String, Bool, StringList), `clear()` |
| `HiveSetup` (`storage/hive_setup.dart`) | Box registry, `clearAllBoxes()` |
| `RemoteConfigService` (`utils/remote_config_service.dart`) | `minVersion`, `latestVersion`, `newVersionDescription` |
| `OrderInvoiceDownloader` (`utils/order_invoice_downloader.dart`) | `download(context:, orderId:, invoiceLabel:)` |
| `TripValidationHelper` (`utils/trip_validation_helper.dart`) | `shouldDisablePassengerControls(trip)`, `getRequiredPassengerCounts(trip)`, `validatePassengerCounts(...)` |
| `SupportedService` (`constants/supported_service.dart`) | `Flights, Hotels, Cabs, Buses, Insurance`; `getImagePath()`, `policyCode`, `policyProduct` |
| `carrierCodeNameMap` (`constants/airline_code.dart`) | Airline code -> name |
| `formatScreenName` (`lib/app_routes.dart`) | Route-settings name |
| Mapper utilities | `AirMapperUtility`, `HotelMapperUtiity`, `BusMapperUtility`, `SsrFilterUtility` (in each feature's `domain/usecases/`) |

### 12.4 Theme
`AppColors`, `TextStyles`, `AppTheme.lightThemeData` in `core/theme/` (sections 11.4, 11.5). Theme also styles `ElevatedButton`, `OutlinedButton`, `TextButton`, `Card`, `Checkbox`, `AppBar`, `FloatingActionButton`; rely on it.

### 12.5 Shared widgets owned by a feature (import from the owner)

| Widget (owner path under `features/`) | Use |
|---|---|
| `ShowRecentSearchesWidget` (`home_screen/presentation/widgets/recent/show_recent_searches_widget.dart`; params `supportedService`, `onClick`) | Recent searches on every search screen |
| `FlightPaymentMethodListWidget` (`flight/presentation/widgets/order/payment_method_list.dart`) | Payment-method sheet for flight, hotel and bus |
| `OrderStatusScreen`, `OrderStatusEnum` (`flight/presentation/pages/order_status_screen.dart`) | Booking result screen |
| `DasshedArrowLine` (`flight/presentation/widgets/dasshed_arrow_line.dart`) | Dashed route arrow |
| `AirlinePill` (`flight/presentation/widgets/airline_pill.dart`) | Airline logo + name |
| `OrderCardHeader` (`home_screen/presentation/widgets/common/order_card_header.dart`; `cartId`, `bookingDate`, `bookingLabel`, `statusText`, `statusColor`, `padding`) | Header of order cards and detail screens |
| `OrderFareSummary` (same folder; `title*`, `amountText*`, `subtitle`, `trailing`, `padding`) plus top-level `formatOrderAmount(double?, String currency)` and `orderCurrencySymbol(String)` | Total-paid block and order currency text (hotel, bus, home_screen) |
| `navigateToService(context, SupportedService)` (`home_screen/presentation/pages/home_screen.dart`) | Opens a product search screen |
| `ItineraryDetail` (`flight/presentation/pages/flight_booking_screen.dart`) | Itinerary block reused by `booking_detailed_screen` |
| Feature blocks worth reusing inside their feature: `BusSectionCard`, `BusJourneyHeroCard`, `BusJourneyTimeline`, `PointCard`, `BusPassengerTile`; `TripStatusBanner`, `TripServiceCard`, `TripBottomBar`; flight add-ons (`AddonPriceDetails`, `BaggageSelectionWidget`, `MealSelectionWidget`, `SeatMapWidget`); hotel detail blocks (`HotelRoomWidget`, `HotelDetailImageWidget`, `HotelSpecialRequestWidget`) | Hotel blocks have legacy styling (raw numbers, off-palette greys): reuse the widget, never copy its styling. There is no `ExpansionTile` in the app; use `GstInfoCard` as the model for collapsible cards and ask before building another |

### 12.6 Wrapped packages (import only the wrapper)

| Package | Wrapper |
|---|---|
| `top_snackbar_flutter` | `WidgetUtil.showSnackBar` |
| `syncfusion_flutter_datepicker` | `DatePicker` |
| `rounded_loading_button_plus` | `CustomButton` (screens import it only for the `RoundedLoadingButtonController` type) |
| `smooth_page_indicator` | `FullScreenImageCarousel` |
| `salomon_bottom_bar` | `CustomBottomNavigationBar` |
| `intl` (`DateFormat`) | `CustomDateUtils` |
| `dio` | `DioClient` |
| `shared_preferences` | `SharedPreferencesRepository` |
| `firebase_remote_config` | `RemoteConfigService` |
| `get_it` | `dependncy_injection.dart` |
| `yaml` | `AppConfig` |
| `map_launcher` | `Utils.launchMap` |
| `open_file` | `OrderInvoiceDownloader` |
| `hive_flutter` | `HiveSetup` and `*_local_service.dart` |

Directly imported, no wrapper: `flutter_bloc`, `bloc`, `equatable`, `collection`, `uuid`, `cached_network_image`, `dotted_line`, `flutter_rating_stars`, `flutter_html`, `flutter_svg`, `dropdown_button2`, `flutter_google_maps_webservices`. Declared but unused (do not start using): `dio_smart_retry`, `dropdown_search`, `indexed`, `cupertino_icons`.

---

## 13. Reuse-first and extraction protocol

1. **Search first.** Section 12, then `ls lib/core/common_widgets lib/core/utils`, then `grep -rn "<distinctive widget / style / string>" lib` for existing copies.
2. **Exists:** use it. **Almost fits:** add an optional parameter whose default keeps today's behaviour, keep all call sites compiling. Never fork it.
3. **Lives in another feature and you need it too:** promote it. Move it to `core/common_widgets/`, fix the imports of its call sites, change no behaviour, say so in your summary.
4. **Does not exist and will be needed in 2+ places** (or is obviously generic: avatar, empty state, section card, network image): create it in `core/common_widgets/<snake_name>.dart`, then use it.
5. **Truly one-off:** public class in its own file under the feature's `widgets/`, or a private `_Widget` / `_buildX()` when it is small and screen-local.

Common-widget recipe:
- `const` constructor with `super.key`, `final` fields, required named parameters first.
- Only `AppColors`, `TextStyles`, `.h` / `.w`. No feature Cubits or pages.
- Variants via an enum parameter with lowerCamel values (`ButtonType`, `PillType`, `ChipType`, `BannerType`), customisation via nullable overrides (`TextStyle? textStyle`, `Color? backgroundColor`) that default to theme tokens.
- No demo screens, no preset "factory" classes (`BannerFactory`, `CustomBannerExamplesScreen` are dead code).
- Add the new widget / util to the catalog in section 12 in the same change.

---

## 14. Cross-feature rules and shared kernel

`flight` is the base feature: the backend's order, payment and order-status API family is shared by flight, hotel and bus, and its models live in `flight`.

| Owner | Shared asset | Used by |
|---|---|---|
| `flight/data/models/booking/**` (`order_status/order_status.dart`, `order/update_order_detail_response.dart`, `order/create_order_response.dart`, `order/update_payment.dart`, `order/payment_medium_request_res.dart`) | Order and payment models | hotel, bus, trip, home_screen |
| `flight/domain/entities/` (`passenger_details_entity`, `passenger_type`, `passenger_title`, `gender`, `profile_type`) | Traveller entities | hotel, bus, `core/common_widgets/passenger_detail` |
| `flight/domain/entities/flight_recent_search.dart` (`AirSearch`) | Air search params | home_screen, trip |
| `AirUseCase.updateOrderPayment / getOrders / getDetailedOrderStauts` | Order list, status, payment endpoints | hotel use case (delegates), `OrderListScreen`, `TripDetailScreen` |
| `flight/domain/usecases/air_mapper_utility.dart` (`getFilteredPaymentMediumStatusList`) | Payment-method filtering by trip | hotel, bus |
| `auth/domain/entities/trip_type.dart`, `auth/data/models/profile/user_booking_profile.dart`, `billing_entity.dart` | Trip policy type, profiles, billing | all booking flows |
| `trip/data/models/trip_response.dart`, `trip_create_request.dart` | Trip models | all booking flows |
| `AuthCubit`, `TripCubit`, `HomeScreenCubit` | Global state | everywhere via `context.read` |

Rules:
1. Before writing an endpoint, check whether another feature already owns that backend API. If it does, your use case holds that feature's use case and delegates (`HotelBookUseCaseImpl` -> `_airUseCase.updateOrderPayment(...)`). Never call another feature's service or repository, never duplicate the URL.
2. A new endpoint that belongs to your feature gets your own service / repository / use case, even when it returns shared models.
3. Shared models stay where they are; import them from the owner's path. Do not copy a model, do not move one unless asked.
4. Cubits obtain cross-feature data through their own feature's use case. A page calling `getIt<AirUseCase>()` directly (`OrderListScreen`, `TripDetailScreen`) is tolerated legacy.
5. Every bookable product honours trip / policy rules. Read `AuthCubit.tripType` and `TripCubit.selectedTrip`. The Pay button reads `tripType == TripType.PreBooking ? "Add to cart" : "Book Now"` (flight: "Pay Now"). On tap: if `selectedTrip != null && tripType == TripType.PreBooking`, take `AirMapperUtility.getFilteredPaymentMediumStatusList(paymentConfig.status, selectedTrip)`; when empty show `WidgetUtil.showSnackBar("No payment methods available", context)`, otherwise run the handler with `.first`. In every other case open `WidgetUtil.showBottomSheet(context, FlightPaymentMethodListWidget(paymentMediumStatusList: <same helper with null trip>, onPaymentMethodSelected: ...))`. The handler: loading on; `updateOrderPayment`; `if (selectedTrip == null || tripType == TripType.PostBooking)` book the order and derive `OrderStatusEnum` (all failed: error, some failed: warning, none: success), else `TripCubit.addToTrip(orderNumber)` (success); then `if (mounted) WidgetUtil.returnToHomeScreen(context, status, tripType)`; `catch` logs and shows "Failed to book order, try again"; `finally` turns loading off (guarded by `mounted`). Travellers lock via `TripValidationHelper.shouldDisablePassengerControls`. Copy `booking_detailed_screen.dart` (`_handlePaymentAndBooking` and the Pay button), not `bus_booking_review_screen.dart` (legacy `Navigator.push`). `AuthCubit.tripType` comes from the user's approval workflow (`policyApplied`: `"1"` = `PreBooking`, empty = `NoTrip`, anything else = `PostBooking`, which is what "book immediately" relies on). Never add a `TripType` value or change this mapping without reading all its callers (R34).

### 14.6 Integrating a new endpoint (curl or sample JSON)

Decide the owner feature first, build bottom-up, then wire. Announce the plan (R31) before creating files.

| Path family (grep `apiBaseUrl}/<segment>` in `*_service.dart`) | Owner |
|---|---|
| `/product/<product>/...`, `/order/<product>/...` (`/product/bus/...`, `/order/hotel/v1`) | that product's feature; air owns `/product/air/...` and the bare `/order/v1...` |
| `/order/orders`, `/orders/findOrderByOrderId/$id`, `/order/v1/$id` (payment update), `/order/details/v1/$id` | flight (`AirUseCase`); every product reuses them through its own use case |
| `/trips/...`, `/tripapproval/...` | trip |
| `/auth/...`, `/crm/...`, `/approval/...`, `/corporate/...` | auth |
| Anything else | the feature whose screen uses it; if unclear, ask |

1. If the path family is served by another feature, your use case holds that feature's use case and delegates. No second service method for the same URL.
2. An endpoint of your own feature gets its own service / repository / use case methods even when it returns shared models (import them from `flight/data/models/booking/**`).
3. Models: JSON keys verbatim, nullable unless the sample always has the field, 6.4 shape, one class per file, nested objects in their own files in a sub-folder named for the group. Names: `<noun>_request.dart`, `<noun>_response.dart`.
4. Polymorphic response (same list, different shapes per supplier): follow `hotel/data/models/details/`: one folder per variant (`mmt/`, `expedia/`, `agoda/`), the parent keeps one nullable field per variant, an enum names the variant (`HotelSourceEnum`), and the mapper converts every variant into one UI entity. Widgets read only the entity.
5. Mixed or unknown shapes: model only what the sample shows and list the rest as "not modelled" in your message.
6. Then service -> repository -> use case with identical signatures; the use case maps entity to request through the `...MapperUtility` (7.3); a DI line only if you added a class (8). Cubit / screen only if the task asks for UI.
7. Ask before coding when the sample lacks: HTTP verb or full path, a success and an error body, which fields are optional, enum value lists, list-vs-wrapper response, or whether the call belongs to a flow that must honour 14.5.

Worked example A (simple): `GET /trips/{tripId}`. Model exists (`trip_response.dart`). `TripService.getTripById` -> `var response = await _dioClient.get('${AppConfig.instance.apiBaseUrl}/trips/$tripId'); return TripResponse.fromMap(response.data);` -> `TripRepository` / `TripRepositoryImpl` pass-through -> `TripUseCase` / `TripUseCaseImpl` pass-through. No DI change. List responses: copy the loop in `BusServiceImpl.getBusCities`.

Worked example B (awkward): hotel details. `POST /product/hotel/_hotelDetails` returns a wide response with supplier-specific rooms, rate plans, policies and taxes, modelled in about 50 one-class files under `hotel/data/models/details/{mmt,expedia,agoda}/`. `HotelBookUseCase.getHotelDetails` builds the request with `HotelMapperUtiity.mapToHotelDetailRequest`; `HotelMapperUtiity` converts the supplier models to `HotelRoom` entities (`domain/entities/rooms/`). Order creation uses hotel-specific `/order/hotel/v1`, but payment update, order list and order status are flight endpoints, so `HotelBookUseCaseImpl` delegates those to `_airUseCase`. A new supplier means a new folder, a mapper method and an enum value, never string branches in widgets.

---

## 15. Copy and formats

- Buttons, app-bar titles, section titles: Title Case ("Book Now", "Search Bus", "Create Trip", "Bus Booking Review").
- Snackbars: short sentences. Validation: "Please select billing entity", "Please add all traveler details". Failure: "Error, please try again" or "Failed to <do thing>, try again". Success uses `col: AppColors.primaryGreen`.
- Empty states: "No <Things> Found".
- Currency: `"₹ ${value.toStringAsFixed(n)}"` with a space after the symbol (41 uses; 6 legacy uses omit the space). Decimals: `2` is the default for totals, fare breakdowns and order screens (28 uses); `1` in bus bottom bars; `0` for add-on / list amounts. Mirror the sibling screen. On order cards and booking-detail screens use `formatOrderAmount(amount, currency)` (12.5).
- Dates for display: `CustomDateUtils.givenFormat(d, "dd MMM yyyy")` for dates; `timeIn24` for times on listing cards, `timeInAmPm` on review screens; weekday + date via `dayDateMonthFormat`. API payload dates via `customApiDayFormat` / `dateTimeInIsoFormatWithoutZone`.
- Separators in subtitles: `" | "` or `" • "`; route arrows `" -> "` (flight) or `" → "` (bus). No emoji in code or UI strings.
- All strings are inline English literals (no l10n layer).

---

## 16. Legacy: misspellings, duplicates, dead code, deviations

These exist in the repo. Reference them exactly as spelled when you must; never rename them, never imitate them.

### 16.1 Misspelled names (exact spelling required when importing or calling)

| Kind | Exact names |
|---|---|
| Files | `lib/dependncy_injection.dart`, `air_searvice.dart`, `hotel_repositoy_impl.dart`, `hotel_search_list_scree.dart`, `hotel_mapper_utiity.dart`, `cutom_dropdown_field.dart`, `labelled_drop_dowdn.dart`, `custom_overlay_dropdownd.dart`, `default_tab_controller_listner.dart`, `form_filed_config.dart`, `dasshed_arrow_line.dart`, `itineray_detail_card.dart`, `selected_itinaries_screen.dart`, `air_addond_selection_screen.dart`, `air_ticekt_widget.dart`, `bagge_ingo.dart`, `passenger_detiald.dart`, `bos_block_response.dart`, `base_search_respose_req_pair.dart` |
| Non snake_case files | `core/common_widgets/ImageIcon.dart`, `core/utils/WidgetUtils.dart`, `hotel-source.dart`, `air_latest_price_detail-search.dart` |
| Classes | `AuthServiceIml`, `HotelDetailCubitCubit`, `HotelDetailCubitState`, `HotelSearchListinError`, `HotelMapperUtiity`, `DasshedArrowLine`, `HotelSearchCase` (no "Use"), `IAuthUseCase` (only `I`-prefixed interface) |
| Methods | `getDetailedOrderStauts`, `udpateHotelPriceDetail`, `udpatePassengerDetailInorder`, `refereshSelectedTrip`, `getfixedPassengerDetails` |
| Widget parameters | `CustomTextFormField`: `cont`, `obs`, `onsave`, `onchange`, `initvalue`, `maxlenght`, `suffixicon`, `erroTextHeihgt`; `CustomDropDownField`: `onchange`, `val`, `data1`; `LabeledInfoWidget.onCLick`; `HotelSearchScreen(hotelSeatch:)` |

For any other file, `grep` for its exact name. A "typo fix" rename breaks imports across the app and is never part of a feature task.

### 16.2 Duplicates (use the canonical one)

| Canonical | Duplicate (do not import, do not copy) |
|---|---|
| `core/common_widgets/bottom_button.dart` | `features/flight/presentation/widgets/bottom_button.dart` (identical; still imported by 10 flight / hotel / bus files) |
| `core/common_widgets/custom_banner.dart` | `core/common_widgets/trip_constraint_banner.dart` (byte-identical, unused) |
| `flight/data/models/seat_map/air_seat.dart` | `flight/data/models/booking/order/air_seat.dart` (unused) |
| `SharedPreferencesRepository.clear()` | `clearAllData()` (same behaviour) |
| `DateTimeParser.calculateAge` (the one in use) | `CustomDateUtils.calculateAge` |
| `FormTitle` (label only) and `TitleFormWidget` (label + child) | both stay; do not add a third label widget |

New code imports `core/common_widgets/bottom_button.dart`. Migrating old call sites is a separate task the owner must request.

### 16.3 Dead code (never imported; not examples to follow)
`core/common_widgets/banner_factory.dart`, `custom_banner_examples.dart`, `service_pills.dart`, `trip_constraint_banner.dart`; `auth/data/models/policy/policy_rule.dart`; `flight/data/models/airsearch/base_air_search_response.dart`; `flight/data/models/booking/order/air_seat.dart`. Never instantiated: `CustomOverlayDropdown` (imported by `hotel_special_request.dart` only) and `getRoomPrice()` in `hotel_detail_screen.dart`. (`bus/presentation/widgets/seat/` is live, via relative imports.) Delete only when asked.

### 16.4 Existing deviations from the rules (do not imitate)
- Raw `showModalBottomSheet` / `showDatePicker` / `showDialog`: `hotel/.../mmt_hotel_policy.dart`, `hotel_high_list_section.dart`, `hotel_amenity_preview.dart`, `hotel_special_request.dart`, `core/.../add_update_passenger_details_screen.dart`, `image_carousel.dart`.
- Raw `TextStyle(...)` / `fontSize:` / `Color(0x..)` / `Colors.<hue>`: `show_update_available_body.dart`, `point_card.dart`, `trip_status_banner.dart`, `custom_text_form_field.dart`, `cutom_dropdown_field.dart`, `air_booking_status.dart`, `bus_journey_hero_card.dart`, `CustomBanner`, `ChipButton`, `TripCard`.
- `print(` in `dio_client.dart`, `common_utils.dart`, `auth_local_service.dart`, `app_update_cubit.dart`, `order_list_screen.dart`.
- `Navigator.push(MaterialPageRoute(...))` in screens: `bus_detail_screen.dart`, `bus_ticket_detail_screen.dart`, `bus_booking_review_screen.dart`, `bus_order_modify_screen.dart`, `flight_order_modify_screen.dart`. Use `WidgetUtil.returnToHomeScreen` / named routes.
- Pages calling `getIt<UseCase>()` directly: `order_list_screen`, `trip_detail_screen`, `booking_detailed_screen`, `hotel_payment_screen`, `bus_booking_review_screen`, `airport_search_screen`, `bus_city_search_screen`, `profile_screen`, `place_search_widget`, `flight_detail_card`.
- Placeholder comments (`// ...existing imports...`) in `hotel_payment_screen`, `profile_screen`, `order_list_screen`; emoji in `date_picker.dart`, `custom_outline_button.dart`, `traveler_profile_tile.dart`.
- Raw `DateFormat(` in feature code: `add_update_passenger_details_screen.dart`, `hotel_special_request.dart` (which also has a wrong pattern `'dd/MM/yyyy mm:HH'`). Raw `Colors.grey` in about 18 files, raw `TextStyle(` / `fontSize:` in about 18 files, `CircularProgressIndicator` in `main.dart`, `image_carousel`, hotel image / room / order widgets, `trip_bottom_bar`; `print` / `debugPrint` in about 8 files (also `size_config.dart`, `trip_detail_screen.dart`, `home_screen.dart`); 3 `// ignore` and 4 `TODO`.
- Raw `EdgeInsets.all(8.0)` / `Radius.circular(10)` style numbers (about 110 raw radii, 14 raw `blurRadius`, 18 raw `EdgeInsets.all`) and non-final fields in `BaseAppBar`, `CustomTextFormField`, `CustomDropDownField`.

### 16.5 Extraction backlog (observed copies; not yet common widgets)
If you need one of these, create the common widget first (section 13) instead of writing another copy. Do not rewrite old call sites unless asked; mention them in your summary.

| Candidate | Seen in |
|---|---|
| Billing-entity bordered dropdown block | flight_booking_screen, hotel_book_form_screen, bus_book_form_screen |
| Booking bottom bar `SizedBox(height: 95.h, width: double.infinity, child: BottomButton(...))` | 9+ screens |
| White section card with soft shadow (title + trailing + child) | `BusSectionCard`, `GstInfoCard`, hotel_booking_detail_screen (x2) |
| Person avatar (`CircleAvatar` + `Icons.person`) | profile_screen, bus_passenger_tile, hotel_payment_screen, hotel_booking_review_screen, selected_user_tags, traveler_profile_tile |
| Network image with spinner + error fallback | hotel detail / room / order card widgets, airline_pill |
| Empty / error state block (icon + title + subtitle + retry) | trip_home_screen, profile_selector_modal, order_list_screen |
| Payment + booking completion handler | booking_detailed_screen, hotel_payment_screen, bus_booking_review_screen |
| Trip-lock traveller parameters (`isReadOnly` + `lockMessage` ternary) | 3 booking forms |
| Price text `"₹ ${x.toStringAsFixed(n)}"` | 47+ places outside order screens (`formatOrderAmount` exists only for orders and lives in home_screen) |
| Private copies of common widgets | `_KeyValueRow` in hotel_booking_detail_screen; four private tag / chip widgets (`_InfoChip`, `_InfoTag`, `_Tag` x2) in bus files; hand-built info banner in bus_detail_screen where `CustomBanner(type: BannerType.info)` exists |
| Per-service order list (Flight / Hotel / Bus blocks) | `OrderListScreen` |
| Private `_Tag`, `_EmptySection` | bus_order_modify / bus_ticket_detail, bus_ticket_detail / hotel_booking_detail |

---

## 17. Anti-patterns (do not do these)

- Adding `flutter_screenutil`, `ScreenUtilInit`, `.sp` / `.r`; or a design-token class (`AppSpacing`, `AppRadius`, `Dimens`, `Gaps`). Spacing is written inline as `SizedBox(height: 12.h)`.
- Creating helper files or classes that duplicate core: `snackbar_helper`, `dialog_utils`, `ui_helpers`, `common.dart`, a new avatar / loader / toast / dialog / button / text-field widget inside a feature.
- Rebuilding Material primitives with custom styling in a feature (`_PrimaryButton`, `_buildTextField`, a local spinner).
- Reading colours or text styles from `Theme.of(context)`; `GoogleFonts`; extra font families.
- Passing `BuildContext` into Cubits, use cases or services. Business logic (filter, sort, pricing, validation rules) inside `build`; it belongs in the Cubit, use case or mapper.
- Hard-coding backend paths outside a service, or keys anywhere.
- `dynamic` or raw `Map` crossing layers when a model exists; comparing status strings in UI when an enum exists.
- Empty `catch (_) {}`; swallowing errors in Cubits (log, then emit `Error` or rethrow).
- `// ignore:` / `// ignore_for_file:`.
- Rewriting a whole file for a surgical change; reformatting, re-sorting imports, renaming, splitting or merging files you were not asked to touch.
- Unrequested extras: tests, README / docs, example screens, demo widgets, preset factories, dependency bumps, version / build-number edits.
- Introducing newer API styles for taste (`withValues`, records-heavy rewrites, `go_router`, Riverpod, Freezed).
- Leaving `// ...existing code...`, emoji, `TODO`, debug prints or commented-out code behind.

---

## 18. Checklists

### 18.1 New screen
1. Pick the golden sample (4.4); create `pages/<name>_screen.dart` with `static const String routeName`.
2. Cubit + state (9) if it loads or mutates data; create it at route level (10.4).
3. Register the route in `app_routes.dart`; navigate with `routeName` + `Map` arguments.
4. Build from catalog widgets only (12); all dimensions `.h` / `.w`; colours and text from theme.
5. Loading / error / empty states per 10.6; snackbars / sheets / popups via `WidgetUtil`.

### 18.2 New API call
When the owner gives you an API (curl, URL, sample request / response), the code must end up looking as if the owner wrote it by hand:
- Treat the sample as the only truth: use its JSON keys verbatim, do not invent fields. Nullable by default; required only when the sample always has it. Unknown or varying parts stay out until confirmed (ask).
- First decide the owner feature: grep `apiBaseUrl}/<path prefix>` in the `*_service.dart` files. If a service already serves that path family (for example `/order/...`), reuse that feature's models and use case (14) instead of creating parallel ones. If the API is awkward (polymorphic, nested, many optional fields), still follow the 6.4 model style; split nested objects into their own model files, as `hotel/data/models/details/**` does.
- Model the response shape you will actually use, then map to a UI entity in a `...MapperUtility` rather than leaking raw API shapes into widgets.
- Say what you will create (models, service method, repo, use case, DI line) before creating it (R31).
- Steps: 1. Model(s) (6.4) in `data/models`. 2. Method on the `XService` interface and Impl (6.1). 3. Same method on repository interface + Impl. 4. Same on use case interface + Impl (+ mapper). 5. If another feature already owns the endpoint family, delegate instead (14). 6. No DI change unless a new class was added (8).

### 18.3 New feature (product)
1. Folder skeleton (4.1). 2. Data -> domain per 6 and 7. 3. Register in `dependncy_injection.dart` (+ `HiveSetup` box if cached). 4. Cubits (9) and screens (10), routes in `app_routes.dart`. 5. Entry points, each only if in scope (ask the owner): `SupportedService` value (+ `getImagePath()` asset, `policyCode`, `policyProduct`), `navigateToService` in `home_screen.dart`, recent searches (`RecentSearchUseCase`, `HomeScreenCubit`, `ShowRecentSearchesWidget`), service list in `OrderListScreen`. 6. Trip / policy / payment handling per 14.5.

### 18.4 New common widget
Follow the recipe in 13, place it in `core/common_widgets/`, use it in your new code, add a row to 12.1.

### 18.5 Before you finish
- [ ] Diff contains no raw dimension numbers, `fontSize`, `TextStyle(`, `Color(0x`, off-palette `Colors.*`, `print`, `showDialog`, `showModalBottomSheet`, `ScaffoldMessenger`.
- [ ] Catalog widgets reused; no duplicate created; any new common widget/util is listed in section 12.
- [ ] Imports are absolute and used; names spelled correctly; file names match classes.
- [ ] `flutter analyze --no-pub <touched files>` once (R32): no new errors / warnings. No project-wide commands.
- [ ] Final message includes a "Spotted" list (R33) and a plain-language summary of every change made.
- [ ] Formatting: `dart format --output=none --set-exit-if-changed <file>`. If the file was clean before your edit, run `dart format <file>`. If it was not (about 100 files are not), hand-format only your lines to match their surroundings; do not run the formatter on the whole file.
- [ ] No placeholder comments, emoji, `TODO`, secrets or unrelated changes (review `git diff`).
- [ ] Final message lists: files changed, shared widgets reused or created, what was and was not run, any rule you could not meet.

---

## 19. Appendix: feature map

| Feature | Owns | Main screens | Cubits | Use case |
|---|---|---|---|---|
| `auth` | Sign-in, user / booking profiles, billing entities, corporate policy, approval workflow | `SignInScreen` | `AuthCubit` (global), `SignInFormCubit` | `IAuthUseCase` |
| `home_screen` | Dashboard shell, home, order list, profile, recent searches, app-update prompt | `Dashboard`, `HomeScreen`, `OrderListScreen`, `ProfileScreen` | `HomeScreenCubit` (global), `AppUpdateCubit` (global) | `RecentSearchUseCase` |
| `flight` | Air search / booking / SSR / seat map / orders; shared order + payment models and traveller entities | `FlightSearchScreen`, `FlightSearchListScreen`, `FlightBookingScreen`, `AirAddonSelectionScreen`, `BookingDetailedScreen`, `FlightTicketScreen`, `FlightOrderModifyScreen`, `OrderStatusScreen` | `FlightSearchCubit`, `FlightSearchListingCubit`, `FlightSearchFilterCubit`, `FlightBookingCubit`, `FlightOrderModifyCubit`, `PassengerDetailFormCubit` | `AirUseCase` |
| `hotel` | Hotel search / detail / booking / payment (MMT, Expedia, Agoda), Google Places | `HotelSearchScreen`, `HotelSearchListScreen`, `HotelDetailScreen`, `HotelBookFormScreen`, `HotelBookingReviewScreen`, `HotelPaymentScreen`, `HotelBookingDetailScreen` | `HotelSearchCubit`, `HotelSearchListingCubit`, `HotelDetailCubitCubit`, `HotelBookCubit` | `HotelSearchCase`, `HotelBookUseCase` |
| `bus` | Bus search / detail / seat selection / booking / cancellation | `BusSearchScreen`, `BusSearchListScreen`, `BusDetailScreen`, `BusBookFormScreen`, `BusBookingReviewScreen`, `BusTicketDetailScreen`, `BusOrderModifyScreen` | `BusSearchCubit`, `BusSearchListingCubit`, `BusSearchFilterCubit`, `BusDetailCubit`, `BusBookCubit`, `BusOrderModifyCubit` | `BusUseCase` |
| `trip` | Corporate trips, trip cart, approval, team trips | `TripHomeScreen`, `TripDetailScreen` | `TripCubit` (global) | `TripUseCase` |

---

## 20. Maintaining this file

- When you add a common widget, util, constant or shared type, add it to section 12 (or 14) in the same change.
- Change a rule only on the owner's instruction. Counts and "about N places" figures describe the 2026-10-17 snapshot; refresh them when they matter, not otherwise.
- Other tools: `CLAUDE.md` holds `@AGENTS.md`, which Claude Code resolves as an import (it does not read `AGENTS.md` on its own). Codex, Cursor, Copilot's agent and Windsurf follow the `AGENTS.md` convention (from general knowledge, not verifiable here). Gemini CLI reads `GEMINI.md` by default; point it at this file through its `context.fileName` setting or a one-line `GEMINI.md` containing `@AGENTS.md`. Do not create more pointer files without asking.
- Keep this file free of duplicated statements: put a rule in one section and reference it from others.
