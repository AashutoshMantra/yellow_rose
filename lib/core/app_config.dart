import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

enum AppStage {
  dev,
  prod,
}

class AppConfig {
  static AppConfig? _instance;
  static AppConfig get instance {
    _instance ??= AppConfig._init();
    return _instance!;
  }

  late AppStage _currentStage;


  late Map<String, String> _urls;

  AppConfig._init();

  Future<void> loadConfig() async {
    final String appConfigString =
        await rootBundle.loadString('app_config.yaml');
    final Map<String, dynamic> appConfigYaml =
        jsonDecode(jsonEncode(loadYaml(appConfigString)));

    const String appFlavor = String.fromEnvironment('FLUTTER_APP_FLAVOR');

    if (appConfigYaml.containsKey(appFlavor)) {
      _currentStage = appFlavor == 'dev' ? AppStage.dev : AppStage.prod;
      final Map<String, dynamic> appConfigData =
          Map<String, dynamic>.from(appConfigYaml[appFlavor]);
      _urls = Map<String, String>.from(appConfigData);
     
    } else {
      throw Exception('Unknown app flavor: $appFlavor');
    }
  }

  AppStage get currentStage => _currentStage;
  String get apiBaseUrl => _urls['apiBaseUrl']!;
  
}
