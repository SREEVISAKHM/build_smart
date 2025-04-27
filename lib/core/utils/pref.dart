import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

final smartPref = BuildSmartPreferences._();

class BuildSmartPreferences {
  BuildSmartPreferences._();

  late SharedPreferences _preferences;

  ///Initializes the [_preferences], to be called in main before using any preferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool.
  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String.
  String? getString(String key) {
    return _preferences.getString(key);
  }

  /// Saves a boolean [value] to persistent storage in the background.
  Future<bool> setBool(String key, bool? value) {
    log('setBool $key: $value', name: 'Build_PREFERENCES');
    if (value == null) return remove(key);
    return _preferences.setBool(key, value);
  }

  /// Removes an entry from persistent storage.
  Future<bool> remove(String key) {
    return _preferences.remove(key);
  }

  Future<bool> clear() {
    log('cleared', name: 'pref');
    return _preferences.clear();
  }
}

abstract class SPKey {
  static const IS_LOGGED = 'isLogged';

  static const IS_Light_Mode = 'isightmode';
}
