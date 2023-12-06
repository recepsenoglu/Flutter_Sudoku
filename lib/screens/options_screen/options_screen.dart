import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/utils/game_strings.dart';
import 'package:flutter_sudoku/screens/options_screen/options_screen_provider.dart';
import 'package:flutter_sudoku/services/game_routes.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_text_styles.dart';
import 'package:flutter_sudoku/widgets/button/done_button.dart';
import 'package:flutter_sudoku/widgets/option_widgets/option_group_widget.dart';
import 'package:flutter_sudoku/widgets/option_widgets/option_widget.dart';
import 'package:provider/provider.dart';

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
              elevation: 0,
              toolbarHeight: 50,
              backgroundColor: GameColors.appBarBackground,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: Text(
                GameStrings.options,
                style: GameTextStyles.optionsScreenAppBarTitle,
              ),
              leading: const SizedBox.shrink(),
              actions: const [DoneButton()],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  OptionGroup(
                    options: [
                      OptionWidget(
                        title: GameStrings.settings,
                        iconColor: Colors.red,
                        iconData: Icons.settings,
                        onTap: () => GameRoutes.goTo(
                          GameRoutes.settingsScreen,
                          enableBack: true,
                        ),
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
                      OptionWidget(
                        title: GameStrings.help,
                        iconColor: Colors.green,
                        iconData: Icons.help,
                        onTap: () => null,
                      ),
                      OptionWidget(
                        title: GameStrings.aboutGame,
                        iconColor: Colors.blue.shade700,
                        iconData: Icons.info,
                        onTap: () => null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    options: [
                      OptionWidget(
                        title: GameStrings.mathPuzzle,
                        iconColor: Colors.purple,
                        iconData: Icons.numbers,
                        onTap: () => null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    options: [
                      OptionWidget(
                        title: GameStrings.removeAds,
                        iconColor: Colors.red,
                        iconData: Icons.no_adult_content_sharp,
                        onTap: () => null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
