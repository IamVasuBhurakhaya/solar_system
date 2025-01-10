class SolarSystemModel {
  final List<PlanetModel> planets;

  SolarSystemModel({required this.planets});
  factory SolarSystemModel.mapToModel(Map<String, dynamic> m1) {
    return SolarSystemModel(
      planets: (m1['solarSystem']['planets'] as List)
          .map((planet) => PlanetModel.mapToModel(planet))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'solarSystem': {
        'planets': planets.map((planet) => planet.toMap()).toList(),
      }
    };
  }
}

class PlanetModel {
  final String name;
  final int orderFromSun;
  final num diameter;
  final String mass;
  final int numberOfSatellites;
  final bool hasRings;
  final String description;
  final String averageOrbitalSpeed;
  final String orbitalPeriod;
  final String image;
  final String surfaceArea;
  final String rotationPeriod;
  final String atmosphere;
  final int temperature;
  final num distanceFromEarth;
  final String type;

  PlanetModel({
    required this.name,
    required this.orderFromSun,
    required this.diameter,
    required this.mass,
    required this.numberOfSatellites,
    required this.hasRings,
    required this.description,
    required this.averageOrbitalSpeed,
    required this.orbitalPeriod,
    required this.image,
    required this.surfaceArea,
    required this.rotationPeriod,
    required this.atmosphere,
    required this.temperature,
    required this.distanceFromEarth,
    required this.type,
  });

  factory PlanetModel.mapToModel(Map<String, dynamic> m1) {
    return PlanetModel(
      name: m1['name'],
      orderFromSun: m1['orderFromSun'],
      diameter: m1['diameter'],
      mass: m1['mass'],
      numberOfSatellites: m1['numberOfSatellites'],
      hasRings: m1['hasRings'],
      description: m1['description'],
      averageOrbitalSpeed: m1['averageOrbitalSpeed'],
      orbitalPeriod: m1['orbitalPeriod'],
      image: m1['image'],
      surfaceArea: m1['surfaceArea'],
      rotationPeriod: m1['rotationPeriod'],
      atmosphere: m1['atmosphere'],
      temperature: m1['temperature'],
      distanceFromEarth: m1['distanceFromEarth'],
      type: m1['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'orderFromSun': orderFromSun,
      'diameter': diameter,
      'mass': mass,
      'numberOfSatellites': numberOfSatellites,
      'hasRings': hasRings,
      'description': description,
      'averageOrbitalSpeed': averageOrbitalSpeed,
      'image': image,
      'surfaceArea': surfaceArea,
      'rotationPeriod': rotationPeriod,
    };
  }
}
