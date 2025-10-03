import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() => _instance;

  late FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService._internal() {
    _remoteConfig = FirebaseRemoteConfig.instance;
  }

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
      
    ));
    await _remoteConfig.fetchAndActivate();
  }

  String get minVersion => _remoteConfig.getString('min_version');
  String get latestVersion => _remoteConfig.getString('latest_version');
  String get newVersionDescription => _remoteConfig.getString('new_version_description');

  // Add other getters here for future Remote Config values
}