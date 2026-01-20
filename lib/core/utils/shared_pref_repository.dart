import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  static SharedPreferences? _prefs;
  static String? documentPath;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    documentPath = (await getApplicationDocumentsDirectory()).path;
    log(documentPath ?? "");
  }

  static putInteger(String key, int value) {
    if (_prefs != null) _prefs!.setInt(key, value);
  }

  static int getInteger(String key) {
    return _prefs == null ? 0 : _prefs!.getInt(key) ?? 0;
  }

  static putDouble(String key, double value) {
    if (_prefs != null) _prefs!.setDouble(key, value);
  }

  static double getDouble(String key) {
    return _prefs == null ? 0 : _prefs!.getDouble(key) ?? 0;
  }

  static putString(String key, String value) {
    if (_prefs != null) _prefs!.setString(key, value);
  }

  static String getString(String key) {
    return _prefs == null ? '' : _prefs!.getString(key) ?? "";
  }

  static putBool(String key, bool value) {
    if (_prefs != null) _prefs!.setBool(key, value);
  }

  static bool getBool(String key) {
    return _prefs == null ? false : _prefs!.getBool(key) ?? false;
  }

  static putStringList(String key, List<String> value) {
    if (_prefs != null) _prefs!.setStringList(key, value);
  }

  static List<String> getStringList(String key) {
    return _prefs == null ? [] : _prefs!.getStringList(key) ?? [];
  }

  static void clear() {
    _prefs?.clear();
  }

  static removeDataForKey(String key) {
    _prefs!.remove(key);
  }

  static void clearAllData() {
    _prefs?.clear();
  }
}
