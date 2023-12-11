import 'package:flutter/material.dart';

import '../../../utils/game_colors.dart';
import '../../../utils/game_routes.dart';
import '../../../utils/game_sizes.dart';
import '../../../utils/game_text_styles.dart';
import '../../../widgets/option_widgets/exports.dart';

class AboutGameScreen extends StatelessWidget {
  const AboutGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GameColors.optionsBackground,
        appBar: AppBar(
          elevation: 0.5,
          centerTitle: true,
          backgroundColor: GameColors.appBarBackground,
          title: Text(
            'About Game',
            style: GameTextStyles.optionsScreenAppBarTitle
                .copyWith(fontSize: GameSizes.getWidth(0.045)),
          ),
          leading: const BackButton(),
        ),
        body: SingleChildScrollView(
          padding: GameSizes.getSymmetricPadding(0.04, 0.04),
          child: Column(
            children: [
              Container(
                padding: GameSizes.getSymmetricPadding(0.04, 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlutterLogo(size: GameSizes.getWidth(0.15)),
                    SizedBox(width: GameSizes.getWidth(0.04)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sudoku - Puzzle Game',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: GameSizes.getWidth(0.042),
                          ),
                        ),
                        SizedBox(height: GameSizes.getWidth(0.025)),
                        Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: GameSizes.getWidth(0.038),
                          ),
                        ),
                        SizedBox(height: GameSizes.getWidth(0.052)),
                        Text(
                          '© 2023 Recep Oğuzhan Şenoğlu',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: GameSizes.getWidth(0.035),
                          ),
                        ),
                        Text(
                          'İstanbul / Türkiye',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: GameSizes.getWidth(0.035),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: GameSizes.getWidth(0.04)),
              OptionGroup(
                options: [
                  OptionWidget(
                    title: 'Privacy Policy',
                    iconColor: Colors.red,
                    iconData: Icons.privacy_tip,
                    onTap: () => GameRoutes.goTo(GameRoutes.privacyPolicyScreen,
                        enableBack: true),
                  ),
                  OptionWidget(
                    title: 'Terms of Use',
                    iconColor: Colors.orange,
                    iconData: Icons.rule,
                    onTap: () => GameRoutes.goTo(GameRoutes.termsOfUseScreen,
                        enableBack: true),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
