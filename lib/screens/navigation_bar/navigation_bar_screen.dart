import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  List<Widget> screens = [
    const Center(
      child: Text('Main Screen'),
    ),
    const Center(
      child: Text('Daily Challenges Screen'),
    ),
    const Center(
      child: Text('Statistics Screen'),
    ),
  ];

  int _selectedIndex = 0;

  void onTappedItem(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: AppColors.appBarBackground,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        onTap: onTappedItem,
        items: navigationBarItems,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.navigationBarItemActive,
        unselectedItemColor: AppColors.navigationBarItemPassive,
        selectedLabelStyle: AppTextStyles.navigationBarItemLabel,
        unselectedLabelStyle: AppTextStyles.navigationBarItemLabel,
      ),
      body: screens[_selectedIndex],
    );
  }

  List<BottomNavigationBarItem> get navigationBarItems => const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 32),
          label: Strings.main,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded, size: 32),
          label: Strings.dailyChallenges,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, size: 32),
          label: Strings.statistics,
        ),
      ];
}
