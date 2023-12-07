import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/exports.dart';
import '../../services/game_routes.dart';
import '../../widgets/button/done_button.dart';
import '../../widgets/option_widgets/exports.dart';
import 'options_screen_provider.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OptionsScreenProvider>(
      create: (context) => OptionsScreenProvider(),
      child: Consumer<OptionsScreenProvider>(
        builder: ((context, provider, _) {
          return Scaffold(
            backgroundColor: GameColors.optionsBackground,
            appBar: AppBar(
              elevation: 0.5,
              leadingWidth: 0,
              centerTitle: true,
              toolbarHeight: GameSizes.getHeight(0.06),
              backgroundColor: GameColors.appBarBackground,
              title: Text(GameStrings.options,
                  style: GameTextStyles.optionsScreenAppBarTitle
                      .copyWith(fontSize: GameSizes.getHeight(0.023))),
              leading: const SizedBox.shrink(),
              actions: const [DoneButton()],
            ),
            body: SingleChildScrollView(
              padding: GameSizes.getSymmetricPadding(0.04, 0.02),
              child: Column(
                children: [
                  OptionGroup(
                    options: [
                      OptionWidget(
                        title: GameStrings.settings,
                        iconColor: Colors.red,
                        iconData: Icons.settings,
                        onTap: () => GameRoutes.goTo(GameRoutes.settingsScreen,
                            enableBack: true),
                      ),
                      OptionWidget(
                        title: GameStrings.howToPlay,
                        iconColor: Colors.orange,
                        iconData: Icons.school,
                        onTap: () => null,
                      ),
                      OptionWidget(
                        title: GameStrings.rules,
                        iconColor: Colors.lightBlue,
                        iconData: Icons.menu_book_rounded,
                        onTap: () => null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    options: [
                      // OptionWidget(
                      //   title: GameStrings.help,
                      //   iconColor: Colors.green,
                      //   iconData: Icons.help,
                      //   onTap: () => null,
                      // ),
                      OptionWidget(
                        title: GameStrings.aboutGame,
                        iconColor: Colors.blue.shade700,
                        iconData: Icons.info,
                        onTap: () => null,
                      ),
                    ],
                  ),
                  // OptionGroup(
                  //   options: [
                  //     OptionWidget(
                  //       title: GameStrings.mathPuzzle,
                  //       iconColor: Colors.purple,
                  //       iconData: Icons.numbers,
                  //       onTap: () => null,
                  //     ),
                  //   ],
                  // ),
                  // OptionGroup(
                  //   options: [
                  //     OptionWidget(
                  //       title: GameStrings.removeAds,
                  //       iconColor: Colors.red,
                  //       iconData: Icons.no_adult_content_sharp,
                  //       onTap: () => null,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
