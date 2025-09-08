# vcare_mobile

A new Flutter project.

## 🛠️ One-Time Setup

1. Install Dart SDK if not already installed.
2. Run the setup script for your OS:

### macOS/Linux

```bash
./setup.sh
```

### Windows

```
./setup.bat
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Amplify Setup

Have amplify config files per flavor pe added like
amplifyconfig/${flavor}/amplifyconfiguration.dart

## Flutter flavor setup

To Setup flavor for flutter from scratch with firebase setup follow [this](https://www.youtube.com/watch?v=Vhm1Cv2uPko)

## Flutter flavors name

- dev
- prod

## Flutter dart define files

Should have config_${flavor}.json at top level with all the sensitive information needed in app (currently only USER_PASSWORD is used , which will store password used while user registration.)
checkout sample_dart_define_file.json file

Sample of how dart define file are used are in into vscode/launch.json

## Build

For building apk or app bundle for android

flutter build appbundle --flavor {flavor} --dart-define-from-file=config_secret.json

For build ipa file for ios do

flutter build ipa --flavor {flavor} --dart-define-from-file=config_config_secret.json

But if you like to create archive from xcode, first run the below code then you can archive in xcode.

flutter build ios --flavor {flavor} --dart-define-from-file=config_config_secret.json --bundle-sksl-path flutter_01.sksl.json
