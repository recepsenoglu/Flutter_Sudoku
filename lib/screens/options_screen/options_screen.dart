import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/screens/options_screen/options_screen_provider.dart';
import 'package:flutter_sudoku/services/routes.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';
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
            backgroundColor: AppColors.optionsBackground,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 50,
              backgroundColor: AppColors.appBarBackground,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: Text(
                Strings.options,
                style: AppTextStyles.optionsScreenAppBarTitle,
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
                        title: Strings.settings,
                        iconColor: Colors.red,
                        iconData: Icons.settings,
                        onTap: () => Routes.goTo(
                          Routes.settingsScreen,
                          enableBack: true,
                        ),
                      ),
                      OptionWidget(
                        title: Strings.howToPlay,
                        iconColor: Colors.orange,
                        iconData: Icons.school,
                        onTap: () => null,
                      ),
                      OptionWidget(
                        title: Strings.rules,
                        iconColor: Colors.lightBlue,
                        iconData: Icons.menu_book_rounded,
                        onTap: () => null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    options: [
                      OptionWidget(
                        title: Strings.help,
                        iconColor: Colors.green,
                        iconData: Icons.help,
                        onTap: () => null,
                      ),
                      OptionWidget(
                        title: Strings.aboutGame,
                        iconColor: Colors.blue.shade700,
                        iconData: Icons.info,
                        onTap: () => null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    options: [
                      OptionWidget(
                        title: Strings.mathPuzzle,
                        iconColor: Colors.purple,
                        iconData: Icons.numbers,
                        onTap: () => null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    options: [
                      OptionWidget(
                        title: Strings.removeAds,
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
