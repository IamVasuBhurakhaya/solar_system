import 'dart:math';
import 'package:flutter/material.dart';
import 'package:galaxy_planets_app/model/solar_model.dart';
import 'package:galaxy_planets_app/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          startAnimation = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeProvider>();
    PlanetModel model =
        ModalRoute.of(context)!.settings.arguments as PlanetModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          model.name,
          style: GoogleFonts.oxygen(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              watch.isFavourite(model.name)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: watch.isFavourite(model.name) ? Colors.red : Colors.white,
            ),
            onPressed: () {
              watch.allFavorites(model.name);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg/bg_1.jpeg'), fit: BoxFit.cover),
            ),
          ),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 2500),
            curve: Curves.easeInOutCirc,
            tween: Tween<double>(begin: -1.0, end: 1.0),
            builder: (context, double value, child) {
              return Align(
                alignment: Alignment(0, value),
                child: Transform.rotate(
                  angle: pi / 2.5 * value,
                  child: Transform.translate(
                    offset: const Offset(4, 0),
                    child: Transform.scale(
                      scale: 5 - value,
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: Image.asset(
              model.image,
              height: 250,
              width: 250,
              fit: BoxFit.contain,
            ),
          ),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 2200),
            curve: Curves.easeInOutCirc,
            tween: Tween<double>(begin: 1.2, end: 1.0),
            builder: (context, double value, _) {
              return Align(
                alignment: Alignment(0, -0.55 + (value - 1.0)),
                child: Opacity(
                  opacity: 6.0 - 5.0 * value,
                  child: Text(
                    model.name,
                    style: GoogleFonts.oxygen(
                      color: Colors.white,
                      fontSize: 80 * value,
                      height: 1.15 * value,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 300),
              Text(
                model.type,
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${model.distanceFromEarth} km from Earth",
                style: GoogleFonts.poppins(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 5.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        detailTiles(
                          icon: Icons.speed,
                          title: 'Average Orbital Speed',
                          value: model.averageOrbitalSpeed,
                        ),
                        detailTiles(
                          icon: Icons.satellite,
                          title: 'Satellites',
                          value: '${model.numberOfSatellites}',
                        ),
                        detailTiles(
                          icon: Icons.public,
                          title: 'Surface Area',
                          value: '${model.surfaceArea} km²',
                        ),
                        detailTiles(
                          icon: Icons.access_time,
                          title: 'Rotation Period',
                          value: model.rotationPeriod,
                        ),
                        detailTiles(
                          icon: Icons.timelapse,
                          title: 'Orbital Period',
                          value: model.orbitalPeriod,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Description',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                textAlign: TextAlign.center,
                                model.description,
                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailTiles({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(0.3),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black87,
          size: 30,
        ),
        title: Text(
          title,
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
