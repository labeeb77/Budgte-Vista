import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_money1/screens/settings/pages/about.dart';
import 'package:my_money1/screens/settings/pages/privacy.dart';
import 'package:my_money1/screens/settings/pages/terms_condition.dart';

import 'package:settings_ui/settings_ui.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../home/screen_home.dart';
import '../home/widgets/colors.dart';
import '../splash/splash_screen.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 240, 240),
      appBar: AppBar(
        backgroundColor: ThemeColor.themeColors,
        title: Text('Settings',
            style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 255, 255, 255))),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SettingsList(
                sections: [
                  SettingsSection(
                    title: const Text(
                      'Common',
                      style:
                          TextStyle(color: Color.fromARGB(255, 116, 127, 133)),
                    ),
                    tiles: <SettingsTile>[
                      SettingsTile(
                        title: const Text('About'),
                        leading: const Icon(Icons.account_box_outlined),
                        onPressed: (context) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutPage(),
                          ),
                        ),
                      ),
                      SettingsTile(
                        title: const Text('Reset App'),
                        leading: const Icon(Icons.restore),
                        onPressed: (context) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Reset App'),
                                content: const Text(
                                    'Do you want to reset the app ?'),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('No')),
                                  TextButton(
                                      onPressed: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        await preferences.clear();
                                        SharedPreferences allData =
                                            await SharedPreferences
                                                .getInstance();
                                        await allData.clear();

                                        final transactionDb = await Hive
                                            .openBox<TransactionModel>(
                                                'transactions-database');
                                        transactionDb.clear();
                                        final categoryDb =
                                            await Hive.openBox<CategoryModel>(
                                                'category-database');
                                        categoryDb.clear();

                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SplashScreen(),
                                                ),
                                                (Route<dynamic> route) =>
                                                    route.isFirst);
                                        ScreenHome.selectedIndexNotifier.value =
                                            0;
                                      },
                                      child: const Text('Yes'))
                                ],
                              );
                            },
                          );
                        },
                      ),
                      SettingsTile(
                        title: const Text('Share'),
                        leading: const Icon(Icons.share),
                        onPressed: ((context) async {
                          await Share.share('Hey, this is a Money manger app');
                        }),
                      ),
                      SettingsTile(
                        title: const Text('Terms and conditions'),
                        leading: const Icon(Icons.notes),
                        onPressed: (context) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsPage(),
                          ),
                        ),
                      ),
                      SettingsTile(
                        title: const Text('Privacy policy'),
                        leading: const Icon(Icons.privacy_tip_outlined),
                        onPressed: (context) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Text(
                'V 1.0.0',
                style: TextStyle(color: Color.fromARGB(255, 129, 126, 126)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
