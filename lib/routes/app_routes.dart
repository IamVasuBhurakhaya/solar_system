import 'package:flutter/material.dart';
import 'package:galaxy_planets_app/screen/favorite/view/favorite_screen.dart';

import '../screen/detail/view/detail_screen.dart';
import '../screen/home/view/home_screen.dart';
import '../screen/splash/view/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home_screen';
  static const String detail = '/detail_screen';
  static const String favourite = '/favourite_screen';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    detail: (context) => const DetailScreen(),
    favourite: (context) => const FavoriteScreen(),
  };
}
