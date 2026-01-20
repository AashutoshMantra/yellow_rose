import 'package:hive_flutter/hive_flutter.dart';

class HiveSetup {
  static final List<String> _boxes = [
    'airports',
    'userProfile',
    'bus_cities',
  ];
  static Future<void> init() async {
    await Hive.initFlutter();
    for (String boxName in _boxes) {
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox(boxName);
      }
    }
  }

  static Future<void> closeAllBoxes() async {
    for (String boxName in _boxes) {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).close();
      }
    }
  }

  static Future<void> clearAllBoxes() async {
    for (String boxName in _boxes) {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).clear();
      } else {
        var box = await Hive.openBox(boxName);
        await box.clear();
      }
    }
  }
}
