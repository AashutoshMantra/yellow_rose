import 'package:yellow_rose/core/constants/supported_service.dart';

abstract class RecentSearchRepo {
  Future<List<T>> getRecentSearches<T>(SupportedService service);
  Future saveRecentSearches<T>(SupportedService service,List<T> data);
}