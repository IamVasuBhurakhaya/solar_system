import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:galaxy_planets_app/model/solar_model.dart';

class SolarHelper {
  Future<List<PlanetModel>> jsonPlanets() async {
    try {
      String json = await rootBundle.loadString("assets/data/data.json");
      var data = jsonDecode(json);
      List<dynamic> list = data['solarSystem']['planets'] ?? [];
      List<PlanetModel> planetList = list
          .map((e) => PlanetModel(
                name: e['name'],
                orderFromSun: e['orderFromSun'],
                diameter: e['diameter'],
                mass: e['mass'],
                numberOfSatellites: e['numberOfSatellites'],
                hasRings: e['hasRings'],
                description: e['description'],
                averageOrbitalSpeed: e['averageOrbitalSpeed'],
                orbitalPeriod: e['orbitalPeriod'],
                image: e['image'],
                surfaceArea: e['surfaceArea'],
                rotationPeriod: e['rotationPeriod'],
                atmosphere: e['atmosphere'],
                distanceFromEarth: e['distanceFromEarth'],
                type: e['type'],
                temperature: e['temperature'],
              ))
          .toList();

      return planetList;
    } catch (e) {
      print("--Error--");
      return [];
    }
  }
}
