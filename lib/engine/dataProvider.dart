import "package:shared_preferences/shared_preferences.dart";

class UsePreferences {
  static SharedPreferences _pref;
  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }
  static SharedPreferences get pref => _pref;
}
