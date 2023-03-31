import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  static const login = "login";
static Future<bool> getLoggedInStatus()async{
  final prefs=await SharedPreferences.getInstance();
  return prefs.getBool(login)?? false;
}


static Future<void> setLoggedInStatus(bool isLoggedIn)async{

  final prefs=await SharedPreferences.getInstance();

  prefs.setBool(login, isLoggedIn);
}


}