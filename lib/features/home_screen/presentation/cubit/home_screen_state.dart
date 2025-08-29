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

  HomeScreenLoaded(
    super.selectedPage, {
    List<AirSearch>? recentAirSearch,
    List<HotelSearch>? recentHotelSearch,
  })  : recentAirSearch = recentAirSearch ?? List.empty(),
        recentHotelSearch = recentHotelSearch ?? List.empty();

  HomeScreenLoaded copyWith({
    List<AirSearch>? recentAirSearch,
    List<HotelSearch>? recentHotelSearch,
    int? selectedPage,
  }) {
    return HomeScreenLoaded(
      selectedPage ?? this.selectedPage,
      recentHotelSearch: recentHotelSearch ?? this.recentHotelSearch,
      recentAirSearch: recentAirSearch ?? this.recentAirSearch,
    );
  }

  @override
  List<Object> get props => [recentAirSearch, selectedPage, recentHotelSearch];
}

class HomeScreenError extends HomeScreenState {
  final String errorMessage;

  const HomeScreenError(this.errorMessage) : super(0);

  @override
  List<Object> get props => [errorMessage];
}
