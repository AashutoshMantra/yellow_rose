import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/home_screen/domain/repositories/recent_search_repo.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';

abstract interface class RecentSearchUseCase {
  Future<List<AirSearch>> getAirRecentSearch();
  Future saveAirRecentSearches(List<AirSearch> data);
  Future<List<HotelSearch>> getHotelRecentSearch();
  Future saveHotelRecentSearches(List<HotelSearch> data);
  Future<List<BusSearch>> getBusRecentSearch();
  Future saveBusRecentSearches(List<BusSearch> data);
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

  @override
  Future<List<HotelSearch>> getHotelRecentSearch() async {
    _recentSearchRepo.getRecentSearches<HotelSearch>(SupportedService.Hotels);
    return await _recentSearchRepo
        .getRecentSearches<HotelSearch>(SupportedService.Hotels);
  }

  @override
  Future saveHotelRecentSearches(List<HotelSearch> data) async {
    _recentSearchRepo.saveRecentSearches<HotelSearch>(
        SupportedService.Hotels, data);
  }

  @override
  Future<List<BusSearch>> getBusRecentSearch() async {
    return await _recentSearchRepo
        .getRecentSearches<BusSearch>(SupportedService.Buses);
  }

  @override
  Future saveBusRecentSearches(List<BusSearch> data) async {
    _recentSearchRepo.saveRecentSearches<BusSearch>(
        SupportedService.Buses, data);
  }
}
