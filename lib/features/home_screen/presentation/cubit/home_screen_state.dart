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
  HomeScreenLoaded(
    super.selectedPage, {
    List<AirSearch>? recentAirSearch,
  }) : recentAirSearch = recentAirSearch ?? List.empty();

  HomeScreenLoaded copyWith({
    List<AirSearch>? recentAirSearch,
    int? selectedPage,
  }) {
    return HomeScreenLoaded(
      selectedPage ?? this.selectedPage,
      recentAirSearch: recentAirSearch ?? this.recentAirSearch,
    );
  }

  @override
  List<Object> get props => [recentAirSearch, selectedPage];
}

class HomeScreenError extends HomeScreenState {
  final String errorMessage;

  const HomeScreenError(this.errorMessage) : super(0);

  @override
  List<Object> get props => [errorMessage];
}
