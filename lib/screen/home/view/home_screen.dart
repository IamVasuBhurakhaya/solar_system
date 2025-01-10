import 'dart:math';
import 'package:flutter/material.dart';
import 'package:galaxy_planets_app/provider/home_provider.dart';
import 'package:galaxy_planets_app/routes/app_routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    )..repeat();
    context.read<HomeProvider>().getPlanet();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeProvider>();

    final planetSizes = [
      40.0,
      80.0,
      80.0,
      130.0,
      110.0,
      120.0,
      90.0,
      100.0,
      150.0,
    ];

    const orbitRadius = 150.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey.withOpacity(0.3), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Image.asset(
                'assets/bg/bg_1.jpeg',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Solar System",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
          ),
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Center(
                child: Stack(
                  children: [
                    Positioned(
                      left: MediaQuery.of(context).size.width / 2 -
                          planetSizes[8] / 2,
                      top: MediaQuery.of(context).size.height / 2 -
                          planetSizes[8] / 2,
                      child: Image.asset(
                        'assets/image/sun.png',
                        width: planetSizes[8],
                        height: planetSizes[8],
                      ),
                    ),
                    ...List.generate(watch.planetList.length, (index) {
                      final angle =
                          controller.value * 2 * pi - (index * pi / 4);

                      final offsetX = orbitRadius * cos(angle + pi / 8);
                      final offsetY = orbitRadius * 2 * sin(angle);

                      return Positioned(
                        left: MediaQuery.of(context).size.width / 2 -
                            planetSizes[index] / 2 +
                            offsetX,
                        top: MediaQuery.of(context).size.height / 2 -
                            planetSizes[index] / 2 +
                            offsetY,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.detail,
                              arguments: watch.planetList[index],
                            );
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                watch.planetList[index].image,
                                width: planetSizes[index],
                                height: planetSizes[index],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                watch.planetList[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.favourite);
        },
        backgroundColor: Colors.amber.shade200,
        child: const Icon(
          Icons.star,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
