import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/utils/game_strings.dart';
import 'package:flutter_sudoku/screens/options_screen/settings_screen/settings_screen_provider.dart';
import 'package:flutter_sudoku/services/game_routes.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_text_styles.dart';
import 'package:flutter_sudoku/widgets/app_bar_action_button.dart';
import 'package:flutter_sudoku/widgets/button/done_button.dart';
import 'package:flutter_sudoku/widgets/option_widgets/option_group_widget.dart';
import 'package:flutter_sudoku/widgets/option_widgets/setting_widget.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsScreenProvider>(
      create: (context) => SettingsScreenProvider(),
      child: Consumer<SettingsScreenProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: GameColors.optionsBackground,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 50,
              backgroundColor: GameColors.appBarBackground,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: Text(
                GameStrings.settings,
                style: GameTextStyles.optionsScreenAppBarTitle,
              ),
              leading: AppBarActionButton(
                icon: Icons.arrow_back_ios_new,
                onPressed: () => GameRoutes.back(),
              ),
              actions: [DoneButton(onPressed: () => GameRoutes.back(backTimes: 2))],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  OptionGroup(
                    fullDivider: true,
                    options: [
                      SettingWidget(
                        title: GameStrings.sounds,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                      SettingWidget(
                        title: GameStrings.autoLock,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                      SettingWidget(
                        title: GameStrings.timer,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                      SettingWidget(
                        title: GameStrings.score,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: GameStrings.statisticsMessageDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.statisticsMessage,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: GameStrings.smartHintsDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.smartHints,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: GameStrings.numberFirstInputDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.numberFirstInput,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: GameStrings.mistakeLimitDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.mistakeLimit,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: GameStrings.autoCheckForMistakesDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.autoCheckForMistakes,
                        value: provider.switchValue,
                        onChanged: null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: GameStrings.highLightDuplicatesDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.highLightDuplicates,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: GameStrings.highlightAresDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.highlightAres,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription:
                        GameStrings.highlightIdenticalNumbersDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.highlightIdenticalNumbers,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: GameStrings.hideUsedNumbersDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.hideUsedNumbers,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: GameStrings.autoRemoveNotesDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.autoRemoveNotes,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
