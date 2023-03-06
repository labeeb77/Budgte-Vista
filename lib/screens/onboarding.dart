import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money1/screens/onboard%20screen/onboard_provider.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home/screen_home.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topRight, colors: [
          Color.fromARGB(255, 177, 42, 1),
          Color.fromARGB(192, 252, 139, 105),
          Color.fromARGB(255, 255, 246, 244)
        ])),
        child: Stack(
          children: [
            PageView(
              controller: controller,
              onPageChanged: ((index) {
                context.read<OnboardProvider>().changeScreen(index);
              }),
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/undraw_online_payments_re_y8f2 (1).svg',
                          height: 160,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          ' "Spending less than\nyour income"',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 143, 33, 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/undraw_investing_re_bov7.svg',
                          height: 160,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          ' "Helps you stick to \nYour budgets"',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 143, 33, 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/undraw_digital_currency_qpak.svg',
                          height: 160,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          '"The time to save \n your Money"',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 143, 33, 0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // dot indicator

            Container(
              alignment: const Alignment(0, .80),
              child: Consumer<OnboardProvider>(
                builder: (context, value, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //skip

                    Visibility(
                      visible: value.isSeen,
                      child: GestureDetector(
                        onTap: (() {
                          controller.jumpToPage(2);
                        }),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                              color: Color.fromARGB(255, 143, 33, 0),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    //Dot indicator

                    SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const WormEffect(
                          spacing: 13,
                          dotColor: Colors.black26,
                          activeDotColor: Color.fromARGB(255, 143, 33, 0)),
                    ),

                    //Done
                    value.isLastPage
                        ? GestureDetector(
                            onTap: () async {
                              SharedPreferences preference =
                                  await SharedPreferences.getInstance();
                              preference.setBool('seen', true);

                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScreenHome()),
                                  (route) => false);
                            },
                            child: const Text('Done',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 143, 33, 0),
                                    fontWeight: FontWeight.bold)),
                          )
                        : GestureDetector(
                            onTap: () {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            child: const Text('Next',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 143, 33, 0),
                                    fontWeight: FontWeight.bold)),
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
