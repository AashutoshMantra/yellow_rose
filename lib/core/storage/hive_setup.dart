import 'package:hive_flutter/hive_flutter.dart';

class HiveSetup {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('airports');
    await Hive.openBox('userProfile');
  }
}
