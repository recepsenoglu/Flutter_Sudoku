import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/screens/options_screen/settings_screen/settings_screen_provider.dart';
import 'package:flutter_sudoku/services/routes.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';
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
            backgroundColor: AppColors.optionsBackground,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 50,
              backgroundColor: AppColors.appBarBackground,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: Text(
                Strings.settings,
                style: AppTextStyles.optionsScreenAppBarTitle,
              ),
              leading: AppBarActionButton(
                icon: Icons.arrow_back_ios_new,
                onPressed: () => Routes.back(),
              ),
              actions: [DoneButton(onPressed: () => Routes.back(backTimes: 2))],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  OptionGroup(
                    fullDivider: true,
                    options: [
                      SettingWidget(
                        title: Strings.sounds,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                      SettingWidget(
                        title: Strings.autoLock,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                      SettingWidget(
                        title: Strings.timer,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                      SettingWidget(
                        title: Strings.score,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: Strings.statisticsMessageDescription,
                    options: [
                      SettingWidget(
                        title: Strings.statisticsMessage,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: Strings.smartHintsDescription,
                    options: [
                      SettingWidget(
                        title: Strings.smartHints,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: Strings.numberFirstInputDescription,
                    options: [
                      SettingWidget(
                        title: Strings.numberFirstInput,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: Strings.mistakeLimitDescription,
                    options: [
                      SettingWidget(
                        title: Strings.mistakeLimit,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: Strings.autoCheckForMistakesDescription,
                    options: [
                      SettingWidget(
                        title: Strings.autoCheckForMistakes,
                        value: provider.switchValue,
                        onChanged: null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: Strings.highLightDuplicatesDescription,
                    options: [
                      SettingWidget(
                        title: Strings.highLightDuplicates,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: Strings.highlightAresDescription,
                    options: [
                      SettingWidget(
                        title: Strings.highlightAres,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription:
                        Strings.highlightIdenticalNumbersDescription,
                    options: [
                      SettingWidget(
                        title: Strings.highlightIdenticalNumbers,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: Strings.hideUsedNumbersDescription,
                    options: [
                      SettingWidget(
                        title: Strings.hideUsedNumbers,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: Strings.autoRemoveNotesDescription,
                    options: [
                      SettingWidget(
                        title: Strings.autoRemoveNotes,
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
