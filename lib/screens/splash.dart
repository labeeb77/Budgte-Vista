

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../database/transaction/transaction_db.dart';
// import 'home/screen_home.dart';
// import 'onboarding.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   void openHome() {
//     Navigator.of(context)
//         .pushReplacement(MaterialPageRoute(builder: (context) => ScreenHome()));
//   }

//   void openIntro() {
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const Onboarding()));
//   }

//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () async {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       bool seen = (prefs.getBool('seen') ?? false);

//       if (seen) {
//         await TransactionsDB.instance.refresh();
//         openHome();
//       } else {
//         openIntro();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//             child: Text(
//               "MyMoney",style: GoogleFonts.quicksand(
//                  fontSize: 40,
//                  fontWeight: FontWeight.w700,
//                 color: const Color.fromARGB(255, 150, 44, 2),
//               ),
//             ),
//           )
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   gotoIntro() async {
//     await Future.delayed(const Duration(seconds: 3));
//     // ignore: use_build_context_synchronously
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: ((context) => const Onboarding()),
//       ),
//     );
//   }
// }
