import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/home_screen/data/datasources/recent_search_local_service.dart';
import 'package:yellow_rose/features/home_screen/domain/repositories/recent_search_repo.dart';

class RecentSearchRepoImpl implements RecentSearchRepo {
  final _recentSearchSource=getIt<RecentSearchLocalService>();
  @override
  Future<List<T>> getRecentSearches<T>(SupportedService service) async{
    return await _recentSearchSource.getRecentSearches(service);
  }

  @override
  Future saveRecentSearches<T>(SupportedService service, List<T> data) {
    return _recentSearchSource.saveRecentSearches(service, data);
  }

}