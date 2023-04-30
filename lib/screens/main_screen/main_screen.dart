import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/screens/main_screen/main_screen_provider.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';
import 'package:flutter_sudoku/widgets/appBar_action_button.dart';
import 'package:flutter_sudoku/widgets/button/rounded_button/rounded_button.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool continueGame = false;

    return Scaffold(
      backgroundColor: AppColors.mainScreenBg,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 52,
        backgroundColor: AppColors.mainScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: const SizedBox.shrink(),
        actions: [
          AppBarActionButton(
              icon: Icons.emoji_events_outlined, onPressed: () {}),
          AppBarActionButton(icon: Icons.settings_outlined, onPressed: () {}),
        ],
      ),
      body: ChangeNotifierProvider<MainScreenProvider>(
        create: (context) => MainScreenProvider(),
        child: Consumer<MainScreenProvider>(builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            child: Column(
              children: [
                const ChallengeAndEvents(),
                const GameTitle(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                  visible: continueGame,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: RoundedButton(
                                      buttonText: Strings.continueGame,
                                      subText: '00:05 - Easy',
                                      subIcon: Icons.watch_later_outlined,
                                      onPressed: () {},
                                    ),
                                  )),
                              RoundedButton(
                                buttonText: Strings.newGame,
                                whiteButton: continueGame,
                                elevation: continueGame ? 2 : 0,
                                onPressed: provider.newGame,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 86,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class GameTitle extends StatelessWidget {
  const GameTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 130, horizontal: 56),
      child: FittedBox(
        child: Center(
          child: Text(
            Strings.gameTitle,
            style: AppTextStyles.mainScreenTitle,
          ),
        ),
      ),
    );
  }
}

class ChallengeAndEvents extends StatelessWidget {
  const ChallengeAndEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all()),
    );
  }
}
