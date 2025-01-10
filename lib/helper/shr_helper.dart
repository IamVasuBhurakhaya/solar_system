import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  Future<void> setFavouritePlanets(List<String> favouritePlanets) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favourites', favouritePlanets);
  }

  Future<List<String>> getFavouritePlanets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favourites') ?? [];
  }
}
