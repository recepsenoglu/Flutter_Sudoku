import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';

import '../../models/game_model.dart';
import '../../utils/game_colors.dart';
import '../../utils/game_strings.dart';
import '../../utils/game_text_styles.dart';
import '../main_screen/main_screen.dart';
import '../statistics_screen/statistics_screen.dart';

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
      const StatisticsScreen(),
    ];
    return Scaffold(
      backgroundColor: GameColors.background,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        onTap: onTappedItem,
        items: navigationBarItems,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: GameColors.navigationBarItemActive,
        unselectedItemColor: GameColors.navigationBarItemPassive,
        selectedLabelStyle: GameTextStyles.navigationBarItemLabel
            .copyWith(fontSize: GameSizes.getWidth(0.032)),
        unselectedLabelStyle: GameTextStyles.navigationBarItemLabel.copyWith(
          fontSize: GameSizes.getWidth(0.032),
        ),
      ),
      body: screens[_selectedIndex],
    );
  }

  List<BottomNavigationBarItem> get navigationBarItems => [
        BottomNavigationBarItem(
          label: GameStrings.main,
          icon: Icon(Icons.home, size: GameSizes.getWidth(0.08)),
        ),
        BottomNavigationBarItem(
          label: GameStrings.statistics,
          icon: Icon(Icons.bar_chart, size: GameSizes.getWidth(0.08)),
        ),
      ];
}
