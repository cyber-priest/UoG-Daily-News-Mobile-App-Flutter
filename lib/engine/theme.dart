import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uog_daily/engine/dataProvider.dart';

class CustomeTheme extends ChangeNotifier {
  ThemeData _themeData;
  SharedPreferences pref = UsePreferences.pref;
//ffb703, 00b4d8
  final ThemeData lightMode = ThemeData(
      primaryColor: Color(0xff3E4685),
      accentColor: Color(0xffF2F8FD),
      scaffoldBackgroundColor: Color(0xffF2F8FD),
      colorScheme: ColorScheme.light(
        primary: Color(0xff3E4685),
        secondary: Color(0xffF2F8FD).withOpacity(0.8),
        primaryVariant: Colors.black87,
        secondaryVariant: Colors.white,
        background: Colors.white,
        surface: Color(0xffffb703),
        onSurface: Colors.white,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Color(0xff3E4685),
        actionTextColor: Colors.white,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.black,
        ),
        headline2: TextStyle(
          color: Colors.black87,
        ),
        headline3: TextStyle(
          color: Color(0xff3E4685),
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xff3E4685),
          )));

  final ThemeData darkMode = ThemeData(
      primaryColor: Color(0xFF0a0b16),
      accentColor: Color(0xff1e2342),
      scaffoldBackgroundColor: Color(0xff0d0f1d),
      colorScheme: ColorScheme.dark(
        primary: Color(0xffF2F8FD),
        secondary: Color(0xffa0a0a0),
        primaryVariant: Colors.white54,
        secondaryVariant: Color(0xFF0a0b16),
        background: Color(0xff121529),
        surface: Color(0xffffb703),
        onSurface: Color(0xffffb703),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Color(0xff3E4685),
        actionTextColor: Colors.white,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Color(0xffF2F8FD),
        ),
        headline2: TextStyle(
          color: Color(0xffa0a0a0),
        ),
        headline3: TextStyle(
          color: Color(0xffa0a0a0),
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff121529),
          iconTheme: IconThemeData(
            color: Colors.white,
          )));

  ThemeData onstart() {
    bool isLight = pref.getBool("light") ?? true;
    if (isLight) {
      _themeData = lightMode;
    } else {
      _themeData = darkMode;
    }
    return _themeData;
  }

  changeTheme() async {
    bool isLight = pref.getBool("light");
    if (isLight == true) {
      _themeData = darkMode;
      pref.setBool("light", false);
    } else {
      _themeData = lightMode;
      pref.setBool("light", true);
    }
    notifyListeners();
  }

  chooseChange(bool val) async {
    if (val == true) {
      _themeData = lightMode;
      pref.setBool("light", true);
    } else {
      _themeData = darkMode;
      pref.setBool("light", false);
    }
    notifyListeners();
  }

  ThemeData get theme => _themeData;
  bool get isWhite => pref.getBool("light") ?? true;
}
