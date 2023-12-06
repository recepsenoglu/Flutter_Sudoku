import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/game_model.dart';
import '../../services/game_routes.dart';
import '../../utils/game_colors.dart';
import '../../utils/game_strings.dart';
import '../../utils/game_text_styles.dart';
import '../../utils/game_sizes.dart';
import '../../widgets/app_bar_action_button.dart';
import '../../widgets/button/rounded_button/rounded_button.dart';
import 'main_screen_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({this.savedGame, super.key});

  final GameModel? savedGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.mainScreenBg,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: GameSizes.getHeight(0.07),
        backgroundColor: GameColors.mainScreenBg,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: const SizedBox.shrink(),
        actions: [
          AppBarActionButton(
            onPressed: () =>
                GameRoutes.goTo(GameRoutes.optionsScreen, enableBack: true),
            icon: Icons.settings_outlined,
            iconSize: GameSizes.getHeight(0.035),
          ),
          SizedBox(width: GameSizes.getWidth(0.02)),
        ],
      ),
      body: ChangeNotifierProvider<MainScreenProvider>(
        create: (context) => MainScreenProvider(savedGame: savedGame),
        child: Consumer<MainScreenProvider>(builder: (context, provider, _) {
          return Padding(
            padding: GameSizes.getSymmetricPadding(0.05, 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ChallengeAndEvents(),
                const GameTitle(),
                Container(
                  height: GameSizes.getHeight(0.25),
                  padding: GameSizes.getHorizontalPadding(0.05),
                  child: Column(
                    children: [
                      Visibility(
                          visible: provider.isThereASavedGame,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: GameSizes.getHeight(0.02)),
                            child: RoundedButton(
                              buttonText: GameStrings.continueGame,
                              subText: provider.continueGameButtonText,
                              subIcon: Icons.watch_later_outlined,
                              onPressed: provider.continueGame,
                            ),
                          )),
                      RoundedButton(
                        buttonText: GameStrings.newGame,
                        whiteButton: provider.isThereASavedGame,
                        elevation: provider.isThereASavedGame ? 5 : 0,
                        onPressed: provider.newGame,
                      ),
                    ],
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
  const GameTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: GameSizes.getHorizontalPadding(0.05),
      child: FittedBox(
        child: Center(
          child: Text(
            GameStrings.gameTitle,
            style: GameTextStyles.mainScreenTitle.copyWith(
              fontSize: GameSizes.getHeight(0.05),
            ),
          ),
        ),
      ),
    );
  }
}

class ChallengeAndEvents extends StatelessWidget {
  const ChallengeAndEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GameSizes.getHeight(0.25),
      width: double.infinity,
      padding: GameSizes.getPadding(0.02),
      decoration: BoxDecoration(border: Border.all()),
      child: Center(
        child: Text(
          'This app is being developed by \n @recepsenoglu',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: GameSizes.getHeight(0.025),
          ),
        ),
      ),
    );
  }
}
