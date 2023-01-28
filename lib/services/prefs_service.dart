
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager{
  // Firebase token
  static Future<bool> saveFCM(String token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString('fcm_token', token);
  }

  static Future<String> getFCM() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('fcm_token') ?? '';
  }
}