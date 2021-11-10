import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "false";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceEmailKey = "USEREMAILKEY";
  static String sharedPreferenceRoleKey = "ROLEKEY";

  //setter
  static Future<void> saveUserLoggedInSharedPereference(
      bool isUserLoggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(
        sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<void> saveUserNameSharedPereference(String userName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceUserNameKey, userName);
  }

  static Future<void> saveUserEmailPereference(String userEmail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceEmailKey, userEmail);
  }

  static Future<void> saveUserRolePereference(String userRole) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(sharedPreferenceRoleKey, userRole);
  }

  //Getter
  static Future getUserEmailPereference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(sharedPreferenceEmailKey);
  }

  static Future getUserNameSharedPereference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(sharedPreferenceUserNameKey);
  }

  static Future getUserLoggedInSharedPereference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future getUserRolePereference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(sharedPreferenceRoleKey);
  }
}
