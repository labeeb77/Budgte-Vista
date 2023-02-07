import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/widgets/colors.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy',
            style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 255, 255, 255))),
        centerTitle: true,
        backgroundColor: ThemeColor.themeColors,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Text(
            'We collect information about your activity in our services,which we use to do things like recommending a YouTube video you might like.\nTerms you search for videos you watch.Views and interactions with content and ads.Voice and audio information.Purchase activity. People with whom you communicate or share content. Activity on third-party sites and apps that use ourservices.Chrome browsing history you have synced with your Google Account. If you use our services to make and receive calls or send and receive messages, we may collect call and message log information like your phone number, calling-party number, receiving-party number, forwarding numbers, sender and recipient email address, time and date of calls and messages, duration of calls, routing information, and types andvolumes of calls and messages. You can visit your Google Account to find and manage activity information that is saved in your account.'),
      ),
    );
  }
}
