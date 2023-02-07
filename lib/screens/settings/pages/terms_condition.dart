import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/widgets/colors.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: GoogleFonts.quicksand(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        backgroundColor: ThemeColor.themeColors,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Text(
            'Welcome to MyMoney. These terms and conditions outline the rules and regulations for the use of Budget Tracker.By using this app we assume you accept these terms and conditions. Do not continue to use Budget Tracker if you do not agree to take all of the terms and conditions stated on this page.The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Companys terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Clients needs in respect of provision of the Companys stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.'),
      ),
    );
  }
}
