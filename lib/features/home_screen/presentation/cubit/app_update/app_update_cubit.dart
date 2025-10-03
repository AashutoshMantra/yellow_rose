import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';
import 'package:upgrader/upgrader.dart';
import 'package:yellow_rose/core/utils/remote_config_service.dart';
import 'package:yellow_rose/core/utils/shared_pref_repository.dart';

part 'app_update_state.dart';

class AppUpdateCubit extends Cubit<AppUpdateState> {
  AppUpdateCubit() : super(AppUpdateInitial());
  static const String _lastPromptKey = 'last_update_prompt';
  static const String _lastPromptedVersionKey = 'last_prompted_version';

  Future<void> checkForUpdates() async {
    emit(AppUpdateChecking());
    try {
      var packageInfo = await PackageManager.getPackageInfo();
      if (Platform.isAndroid) {
        InAppUpdateManager manager = InAppUpdateManager();
        AppUpdateInfo? appUpdateInfo = await manager.checkForUpdate();
        print("State AppUpdate compute ${appUpdateInfo?.updateAvailability}");
        if (appUpdateInfo?.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          PlayStoreSearchAPI playStoreSearchAPI = PlayStoreSearchAPI();
          var result = await playStoreSearchAPI
              .lookupById(packageInfo.packageName, country: 'IN');
          var (forceUpdate, description) =
              await checkForForceUpdate(packageInfo);
          emit(AppUpdateAvailable(
              appUpdateInfo: appUpdateInfo,
              version:
                  "${playStoreSearchAPI.version(result!)}.${appUpdateInfo!.availableVersionCode}",
              manager: manager,
              forceUpdate: forceUpdate,
              description: description));
        } else {
          emit(NoAppUpdateAvailable());
        }
      } else {
        VersionInfo? versionInfo2 = await UpgradeVersion.getiOSStoreVersion(
          packageInfo: packageInfo,
          regionCode: 'IN',
        );

        if (versionInfo2.canUpdate) {
          var (forceUpdate, description) =
              await checkForForceUpdate(packageInfo);
          emit(AppUpdateAvailable(
              versionInfo: versionInfo2,
              version: versionInfo2.storeVersion,
              forceUpdate: forceUpdate,
              description: description));
        } else {
          emit(NoAppUpdateAvailable());
        }
      }
    } catch (error, stack) {
      print("Error app udpate $stack");
      emit(const AppUpdateError("Failed to check for updates"));
    }
  }

  Future<void> setLastPromptTime(DateTime time) async {
    await SharedPreferencesRepository.putInteger(
        _lastPromptKey, time.millisecondsSinceEpoch);
  }

  Future<DateTime?> getLastPromptTime() async {
    final timestamp = SharedPreferencesRepository.getInteger(_lastPromptKey);
    if (timestamp > 0) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }

    return null;
  }

  Future<void> setLastPromptedVersion(String version) async {
    if (state is AppUpdateAvailable &&
        (state as AppUpdateAvailable).version != null) {
      await SharedPreferencesRepository.putString(
          _lastPromptedVersionKey, (state as AppUpdateAvailable).version!);
    }
  }

  Future<String?> getLastPromptedVersion() async {
    return SharedPreferencesRepository.getString(_lastPromptedVersionKey);
  }

  Future<void> setLastPromptInfo() async {
    if (state is AppUpdateAvailable) {
      await setLastPromptTime(DateTime.now());
      await setLastPromptedVersion((state as AppUpdateAvailable).version!);
    }
  }

  Future<bool> shouldShowUpdatePrompt() async {
    if (state is AppUpdateAvailable) {
      final lastPromptedVersion = await getLastPromptedVersion();
      final lastPromptTime = await getLastPromptTime();

      final now = DateTime.now();
      if ((state as AppUpdateAvailable).forceUpdate) {
        return true;
      }

      // Show prompt if it's a new version
      if ((state as AppUpdateAvailable).version != lastPromptedVersion) {
        return true;
      }

      // Show prompt if enough time has passed since the last one
      if (lastPromptTime == null ||
          now.difference(lastPromptTime).inDays >= 7) {
        return true;
      }

      // Otherwise, do not show the prompt
      return false;
    }
    return false;
  }

  static Future<(bool, String)> checkForForceUpdate(
      PackageInfo packageInfo) async {
    String currentFullVersion =
        '${packageInfo.version}+${packageInfo.buildNumber}';

    String minVersion = RemoteConfigService().minVersion;
    String updateMessage = RemoteConfigService().newVersionDescription;

    return (_isUpdateRequired(currentFullVersion, minVersion), updateMessage);
  }

  static bool _isUpdateRequired(String currentVersion, String minVersion) {
    List<String> currentParts = currentVersion.split('+');
    List<String> minParts = minVersion.split('+');

    if (currentParts.length < 2 || minParts.length < 2) return false;

    List<int> currentVersionNumbers =
        currentParts[0].split('.').map(int.parse).toList();
    int currentBuildNumber = int.tryParse(currentParts[1]) ?? 0;

    List<int> minVersionNumbers =
        minParts[0].split('.').map(int.parse).toList();
    int minBuildNumber = int.tryParse(minParts[1]) ?? 0;

    for (int i = 0; i < minVersionNumbers.length; i++) {
      if (i >= currentVersionNumbers.length ||
          currentVersionNumbers[i] < minVersionNumbers[i]) {
        return true;
      } else if (currentVersionNumbers[i] > minVersionNumbers[i]) {
        return false;
      }
    }

    return currentBuildNumber < minBuildNumber;
  }
}
