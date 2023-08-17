import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void putStringData({
    required String key,
    required String value
}){
    sharedPreferences.setString(key, value);
  }

  static String? getStringData({
    required String key,
}){
    return sharedPreferences?.getString(key);
  }

  static void deleteStringData({
    required String key,
  }){
    sharedPreferences.remove(key)!;
  }
}

