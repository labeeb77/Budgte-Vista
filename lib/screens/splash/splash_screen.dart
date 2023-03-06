import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money1/screens/home/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
        Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = (prefs.getBool('seen') ?? false);

    // ignore: use_build_context_synchronously
    seen ? openHome(context) : gotoIntro(context); 
    });
    return Scaffold(
      body: Center(
            child: Text(
              "MyMoney",style: GoogleFonts.quicksand(
                 fontSize: 40,
                 fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 150, 44, 2),
              ),
            ),
          )
    );
  }
 gotoIntro(context) async {
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: ((context) =>  Onboarding()),
      ),
    );
  }
  Future<void> openHome(context) async{
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  ScreenHome()));
  }


}