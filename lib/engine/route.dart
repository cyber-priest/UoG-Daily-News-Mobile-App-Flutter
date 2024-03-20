import 'package:flutter/material.dart';
import 'package:uog_daily/screens/about.dart';
import 'package:uog_daily/screens/app.dart';
import 'package:uog_daily/screens/contactUs.dart';
import 'package:uog_daily/screens/services.dart';
import 'package:uog_daily/screens/settings.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String services = '/services';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String contactUs = '/contactUs';

  static Map<String, WidgetBuilder> _routes = {
    homePage: (BuildContext context) => App(),
  };

  static Route<dynamic> generator(RouteSettings setting) {
    switch (setting.name) {
      case services:
        return MaterialPageRoute(builder: (_) => Services());

      case settings:
        return MaterialPageRoute(builder: (_) => Settings());

      case about:
        return MaterialPageRoute(builder: (_) => About());

      case contactUs:
        return MaterialPageRoute(builder: (_) => ContactUs());

      case homePage:
        return MaterialPageRoute(builder: (_) => App());
    }
  }

  static Map get routes => _routes;
}
