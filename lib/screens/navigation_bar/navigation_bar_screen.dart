import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_strings.dart';
import 'package:flutter_sudoku/models/game_model.dart';
import 'package:flutter_sudoku/screens/daily_challenges_screen/daily_challenges_screen.dart';
import 'package:flutter_sudoku/screens/main_screen/main_screen.dart';
import 'package:flutter_sudoku/screens/statistics_screen/statistics_screen.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/app_text_styles.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({
    super.key,
    this.pageIndex,
    this.savedGame,
  });

  final int? pageIndex;
  final GameModel? savedGame;

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = -1;

  void onTappedItem(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex =
        _selectedIndex == -1 ? (widget.pageIndex ?? 0) : _selectedIndex;

    List<Widget> screens = [
      MainScreen(savedGame: widget.savedGame),
      const DailyChallengesScreen(),
      const StatisticsScreen(),
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
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
          label: AppStrings.main,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded, size: 32),
          label: AppStrings.dailyChallenges,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, size: 32),
          label: AppStrings.statistics,
        ),
      ];
}
