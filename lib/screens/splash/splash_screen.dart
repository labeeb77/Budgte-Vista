import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money1/screens/home/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  bool animationCompleted = false;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(
        () {
          setState(() {});
        },
      );
    animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          animationCompleted = true;
        });
        navigateToNextScreen();
      }
    });
    animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  void navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    // ignore: use_build_context_synchronously
    seen ? openHome(context) : gotoIntro(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                Color.fromARGB(255, 150, 44, 2),
                Color.fromARGB(255, 255, 210, 73),
              ],
              tileMode: TileMode.repeated,
              stops: const [0.0, 1.0],
              transform:
                  GradientRotation(animationController!.value * 2 * 3.14),
            ).createShader(bounds);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Budget Vista",
                style: GoogleFonts.philosopher(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors
                      .white, // Text color will be replaced by the gradient
                ),
              ),
              const Text('The time to save your Money')
            ],
          ),
        ),
      ),
    );
  }

  gotoIntro(context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: ((context) => Onboarding()),
      ),
    );
  }

  Future<void> openHome(context) async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => ScreenHome()));
  }
}
