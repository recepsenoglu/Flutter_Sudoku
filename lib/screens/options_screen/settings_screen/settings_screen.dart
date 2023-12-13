import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/exports.dart';
import '../../../utils/game_routes.dart';
import '../../../widgets/button/custom_text_button.dart';
import '../../../widgets/option_widgets/exports.dart';
import 'settings_screen_provider.dart';

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
              elevation: 0.5,
              centerTitle: true,
              backgroundColor: GameColors.appBarBackground,
              title: Text(GameStrings.settings,
                  style: GameTextStyles.optionsScreenAppBarTitle
                      .copyWith(fontSize: GameSizes.getWidth(0.045))),
              leading: const BackButton(),
              actions: [
                CustomTextButton(onPressed: () => GameRoutes.back(backTimes: 2))
              ],
            ),
            body: SingleChildScrollView(
              padding: GameSizes.getSymmetricPadding(0.04, 0.02),
              child: Column(
                children: [
                  OptionGroup(
                    dividerPadding: GameSizes.getWidth(0.045),
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
                    groupDescription:
                        GameStrings.autoCheckForMistakesDescription,
                    options: [
                      SettingWidget(
                        title: GameStrings.autoCheckForMistakes,
                        value: provider.switchValue,
                        onChanged: null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription:
                        GameStrings.highLightDuplicatesDescription,
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
