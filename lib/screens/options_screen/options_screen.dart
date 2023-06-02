import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/screens/options_screen/options_screen_provider.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';
import 'package:flutter_sudoku/widgets/button/done_button.dart';
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
                        iconData: Icons.settings_applications,
                        onTap: () => null,
                      ),
                      OptionWidget(
                        title: Strings.howToPlay,
                        iconColor: Colors.orange,
                        iconData: Icons.settings_applications,
                        onTap: () => null,
                      ),
                      OptionWidget(
                        title: Strings.rules,
                        iconColor: Colors.blue,
                        iconData: Icons.settings_applications,
                        onTap: () => null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    options: [
                      OptionWidget(
                        title: Strings.help,
                        iconColor: Colors.orange,
                        iconData: Icons.settings_applications,
                        onTap: () => null,
                      ),
                      OptionWidget(
                        title: Strings.aboutGame,
                        iconColor: Colors.blue,
                        iconData: Icons.settings_applications,
                        onTap: () => null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    options: [
                      OptionWidget(
                        title: Strings.mathPuzzle,
                        iconColor: Colors.orange,
                        iconData: Icons.settings_applications,
                        onTap: () => null,
                      ),
                    ],
                  ),
                  OptionGroup(
                    options: [
                      OptionWidget(
                        title: Strings.removeAds,
                        iconColor: Colors.orange,
                        iconData: Icons.settings_applications,
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

class OptionGroup extends StatelessWidget {
  const OptionGroup({
    required this.options,
    this.fullDivider = false,
    super.key,
  });

  final List<OptionWidget> options;
  final bool fullDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 3),
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: List.generate(
          options.length,
          (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => options[index].onTap?.call(),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    child: options[index],
                  ),
                ),
                Visibility(
                  visible: index < options.length - 1,
                  child: Container(
                    height: 0.4,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: fullDivider ? 20 : 50),
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    required this.title,
    required this.iconData,
    required this.iconColor,
    this.onTap,
    super.key,
  });

  final String title;
  final IconData iconData;
  final Color iconColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 34,
          color: iconColor,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppTextStyles.optionButtonTitle,
        ),
        const Spacer(),
        Icon(
          Icons.keyboard_arrow_right,
          color: AppColors.greyColor,
        ),
      ],
    );
  }
}
