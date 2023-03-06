import 'package:flutter/material.dart';
import 'package:my_money1/database/transaction/transaction_provider.dart';
import 'package:my_money1/screens/home/show_screen.dart';
import 'package:my_money1/screens/home/widgets/bottom_nav.dart';
import 'package:my_money1/screens/home/widgets/colors.dart';
import 'package:provider/provider.dart';

import '../../database/category/category_provider.dart';
import '../category/screen_category.dart';
import '../settings/screen_settings.dart';
import '../statitics/screen_statistics.dart';


class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [
    const ShowScreen(),
    const ScreenCategory(),
    const ScreenStatitics(),
    const ScreenSettings()
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionProvider>(context,listen: false).refresh();
    Provider.of<CategoryProvider>(context,listen: false).refreshUI();

    return Scaffold(
      bottomNavigationBar: const BottomNav(),
      backgroundColor: ThemeColor.themeColors,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updateIndex, _) {
            return _pages[updateIndex];
          },
        ),
      ),
    );
  }
}
