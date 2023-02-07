import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home/widgets/colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About',
            style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 255, 255, 255))),
        centerTitle: true,
        backgroundColor: ThemeColor.themeColors,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 100, bottom: 200, left: 30, right: 30),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 15,
                offset: Offset(5, 5),
              ),
              BoxShadow(
                color: Colors.white12,
                blurRadius: 15,
                offset: Offset(-5, -5),
              ),
            ],
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'MyMoney',
                  style: GoogleFonts.quicksand(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'This app can help with automating financial management tasks and provide a clearer picture of your financial status. It can also categorize your income and expenses, generate reports, and help you make informed financial decisions..',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text('Developed by'),
                    Text(
                      'Labeeb. Ak',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(),
                const Text(
                  'Contact Me',
                  style: TextStyle(color: Color.fromARGB(255, 116, 117, 119)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () async {
                          launchUrl(Uri.parse(
                              'https://www.instagram.com/labee_b__/'));
                        },
                        icon: const Icon(FontAwesomeIcons.instagram)),
                    IconButton(
                        onPressed: () async {
                          launchUrl(Uri.parse(
                              'https://www.linkedin.com/in/labeeb-ak-7205a225b/ '));
                        },
                        icon: const Icon(FontAwesomeIcons.linkedin)),
                    IconButton(
                        onPressed: () async {
                          launchUrl(Uri.parse('https://github.com/labeeb77'));
                        },
                        icon: const Icon(FontAwesomeIcons.github)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
