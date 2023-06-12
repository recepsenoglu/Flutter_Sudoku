import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/utils/app_strings.dart';
import 'package:flutter_sudoku/screens/options_screen/settings_screen/settings_screen_provider.dart';
import 'package:flutter_sudoku/services/routes.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/app_text_styles.dart';
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
                AppStrings.settings,
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
                        title: AppStrings.sounds,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                      SettingWidget(
                        title: AppStrings.autoLock,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                      SettingWidget(
                        title: AppStrings.timer,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                      SettingWidget(
                        title: AppStrings.score,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: AppStrings.statisticsMessageDescription,
                    options: [
                      SettingWidget(
                        title: AppStrings.statisticsMessage,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: AppStrings.smartHintsDescription,
                    options: [
                      SettingWidget(
                        title: AppStrings.smartHints,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: AppStrings.numberFirstInputDescription,
                    options: [
                      SettingWidget(
                        title: AppStrings.numberFirstInput,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: AppStrings.mistakeLimitDescription,
                    options: [
                      SettingWidget(
                        title: AppStrings.mistakeLimit,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: AppStrings.autoCheckForMistakesDescription,
                    options: [
                      SettingWidget(
                        title: AppStrings.autoCheckForMistakes,
                        value: provider.switchValue,
                        onChanged: null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: AppStrings.highLightDuplicatesDescription,
                    options: [
                      SettingWidget(
                        title: AppStrings.highLightDuplicates,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: AppStrings.highlightAresDescription,
                    options: [
                      SettingWidget(
                        title: AppStrings.highlightAres,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription:
                        AppStrings.highlightIdenticalNumbersDescription,
                    options: [
                      SettingWidget(
                        title: AppStrings.highlightIdenticalNumbers,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: AppStrings.hideUsedNumbersDescription,
                    options: [
                      SettingWidget(
                        title: AppStrings.hideUsedNumbers,
                        value: provider.switchValue,
                        onChanged: provider.changeValue,
                      ),
                    ],
                  ),
                  OptionGroup(
                    groupDescription: AppStrings.autoRemoveNotesDescription,
                    options: [
                      SettingWidget(
                        title: AppStrings.autoRemoveNotes,
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
