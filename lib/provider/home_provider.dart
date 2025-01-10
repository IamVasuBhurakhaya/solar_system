import 'package:flutter/material.dart';
import 'package:galaxy_planets_app/helper/shr_helper.dart';

import '../../../helper/solar_helper.dart';
import '../../../model/solar_model.dart';

class HomeProvider extends ChangeNotifier {
  List<PlanetModel> planetList = [];
  int selectedIndex = 0;
  List<String> favoritePlanets = [];
  SolarHelper helper = SolarHelper();
  ShrHelper shrHelper = ShrHelper();

  HomeProvider() {
    getPlanet();
    loadFavorites();
  }

  void planetIndex(int index) {
    if (index >= 0 && index < planetList.length) {
      selectedIndex = index;
      notifyListeners();
    }
  }

  Future<void> getPlanet() async {
    planetList = await helper.jsonPlanets();
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    favoritePlanets = await shrHelper.getFavouritePlanets();
    notifyListeners();
  }

  Future<void> allFavorites(String planetName) async {
    if (favoritePlanets.contains(planetName)) {
      favoritePlanets.remove(planetName);
    } else {
      favoritePlanets.add(planetName);
    }

    await shrHelper.setFavouritePlanets(favoritePlanets);
    notifyListeners();
  }

  bool isFavourite(String planetName) {
    return favoritePlanets.contains(planetName);
  }
}
