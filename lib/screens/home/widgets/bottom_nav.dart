import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


import '../screen_home.dart';
import 'colors.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext context, int updateIndex, Widget? _) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: GNav(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutExpo,
              haptic: true,
              iconSize: 22,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              tabBackgroundColor: ThemeColor.themeColors,
              selectedIndex: updateIndex,
              padding: const EdgeInsets.all(12),
              onTabChange: (newIndex) {
                ScreenHome.selectedIndexNotifier.value = newIndex;
              },
              tabs: const [
                GButton(
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                  icon: Icons.category,
                  text: 'category',
                ),
                GButton(
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                  icon: Icons.auto_graph_sharp,
                  text: 'Statitics',
                ),
                GButton(
                  iconActiveColor: Colors.white,
                  textColor: Colors.white,
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
