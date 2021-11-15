import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    debugPrint('SP init');

    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
    } else {
      await sharedPreferences.setInt(key, value);
    }
  }

  static Future<void> deleteData({required String key}) async {
    await sharedPreferences.remove(key);
        // await sharedPreferences.(key);

  }

  Future<bool?> getBoolData({required String key}) async {
    return sharedPreferences.getBool(key);
  }

  static Future<String?> getStringData({required String key}) async {
    return sharedPreferences.getString(key);
  }

  Future<double?> getIntData({required String key}) async {
    return sharedPreferences.getDouble(key);
  }

  Future<int?> getDoubleData({required String key}) async {
    return sharedPreferences.getInt(key);
  }
}
