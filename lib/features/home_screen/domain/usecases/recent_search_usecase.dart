import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/home_screen/domain/repositories/recent_search_repo.dart';

abstract interface class RecentSearchUseCase {
  Future<List<AirSearch>> getAirRecentSearch();
  Future saveAirRecentSearches(List<AirSearch> data);
}

class RecentSearchUseCaseImpl implements RecentSearchUseCase {
  final _recentSearchRepo = getIt<RecentSearchRepo>();
  @override
  Future<List<AirSearch>> getAirRecentSearch() async {
    return await _recentSearchRepo
        .getRecentSearches<AirSearch>(SupportedService.Flights);
  }

  @override
  Future saveAirRecentSearches(List<AirSearch> data) async {
    _recentSearchRepo.saveRecentSearches<AirSearch>(
        SupportedService.Flights, data);
  }
}
