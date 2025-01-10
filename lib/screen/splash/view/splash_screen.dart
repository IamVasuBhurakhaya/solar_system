import 'dart:math';
import 'package:flutter/material.dart';
import 'package:galaxy_planets_app/screen/home/view/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/bg/bg_1.jpeg',
                ),
              ),
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
              'assets/image/4.png',
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Explore",
                        style: GoogleFonts.oxygen(
                          color: Colors.white70,
                          fontSize: 80 * value,
                          height: 1.15 * value,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        ''' Solar  System''',
                        style: GoogleFonts.oxygen(
                            color: Colors.white,
                            fontSize: 65 * value,
                            height: 1.15 * value,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
