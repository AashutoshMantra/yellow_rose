part of 'app_update_cubit.dart';

abstract class AppUpdateState extends Equatable {
  const AppUpdateState();

  @override
  List<Object?> get props => [];
}

class AppUpdateInitial extends AppUpdateState {}

class AppUpdateChecking extends AppUpdateState {}

class AppUpdateAvailable extends AppUpdateState {
  final AppUpdateInfo? appUpdateInfo;
  final VersionInfo? versionInfo;
  final InAppUpdateManager? manager;
  final String? version;
  final String description;
  final bool forceUpdate;

  const AppUpdateAvailable(
      {this.appUpdateInfo,
      this.versionInfo,
      this.version,
      this.manager,
      this.description = "",
      required this.forceUpdate});
  @override
  List<Object?> get props =>
      [appUpdateInfo, versionInfo, manager, version, description, forceUpdate];

  AppUpdateAvailable copyWith({
    AppUpdateInfo? appUpdateInfo,
    VersionInfo? versionInfo,
    InAppUpdateManager? manager,
    String? version,
    String? description,
    bool? forceUpdate,
  }) {
    return AppUpdateAvailable(
      appUpdateInfo: appUpdateInfo ?? this.appUpdateInfo,
      versionInfo: versionInfo ?? this.versionInfo,
      manager: manager ?? this.manager,
      version: version ?? this.version,
      description: description ?? this.description,
      forceUpdate: forceUpdate ?? this.forceUpdate,
    );
  }
}

class NoAppUpdateAvailable extends AppUpdateState {}

class AppUpdateError extends AppUpdateState {
  final String message;

  const AppUpdateError(this.message);
  @override
  List<Object?> get props => [message];
}
