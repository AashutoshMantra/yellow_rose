part of 'home_screen_cubit.dart';

abstract class HomeScreenState extends Equatable {
  final int selectedPage;
  const HomeScreenState(this.selectedPage);

  @override
  List<Object> get props => [selectedPage];
}

class HomeScreenInitial extends HomeScreenState {
  const HomeScreenInitial(super.selectedPage);
}

class HomeScreenLoaded extends HomeScreenState {
  final List<AirSearch> recentAirSearch;
  final List<HotelSearch> recentHotelSearch;
  final List<BusSearch> recentBusSearch;

  HomeScreenLoaded(
    super.selectedPage, {
    List<AirSearch>? recentAirSearch,
    List<HotelSearch>? recentHotelSearch,
    List<BusSearch>? recentBusSearch,
  })  : recentAirSearch = recentAirSearch ?? List.empty(),
        recentHotelSearch = recentHotelSearch ?? List.empty(),
        recentBusSearch = recentBusSearch ?? List.empty();

  HomeScreenLoaded copyWith({
    List<AirSearch>? recentAirSearch,
    List<HotelSearch>? recentHotelSearch,
    List<BusSearch>? recentBusSearch,
    int? selectedPage,
  }) {
    return HomeScreenLoaded(
      selectedPage ?? this.selectedPage,
      recentHotelSearch: recentHotelSearch ?? this.recentHotelSearch,
      recentAirSearch: recentAirSearch ?? this.recentAirSearch,
      recentBusSearch: recentBusSearch ?? this.recentBusSearch,
    );
  }

  @override
  List<Object> get props =>
      [recentAirSearch, selectedPage, recentHotelSearch, recentBusSearch];
}

class HomeScreenError extends HomeScreenState {
  final String errorMessage;

  const HomeScreenError(this.errorMessage) : super(0);

  @override
  List<Object> get props => [errorMessage];
}
