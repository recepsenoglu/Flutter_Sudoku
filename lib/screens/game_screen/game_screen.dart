import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/utils/styles.dart';
import 'package:flutter_sudoku/widgets/appBar_action_button.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      appBar: const GameAppBar(),
    );
  }
}

class GameAppBar extends StatelessWidget with PreferredSizeWidget {
  const GameAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String appBarTitle = 'Flutter Sudoku';

    return AppBar(
      backgroundColor: Styles.appBarBackgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      elevation: 0,
      title: Text(
        appBarTitle,
        style: TextStyle(
          color: Styles.appBarTitleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading:
          AppBarActionButton(icon: Icons.arrow_back_ios_new, onPressed: () {}),
      actions: [
        AppBarActionButton(
          icon: Icons.palette_outlined,
          onPressed: () {},
        ),
        AppBarActionButton(
          icon: Icons.settings_outlined,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
