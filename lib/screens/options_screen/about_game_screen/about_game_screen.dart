import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/game_colors.dart';
import '../../../utils/game_routes.dart';
import '../../../utils/game_sizes.dart';
import '../../../utils/game_text_styles.dart';
import '../../../widgets/option_widgets/exports.dart';

class AboutGameScreen extends StatelessWidget {
  const AboutGameScreen({super.key});

  Future<void> launchPage(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await canLaunchUrl(uri)
          ? await launchUrl(uri)
          : throw 'Could not launch $url';
    } catch (e) {
      debugPrint(e.toString());
      log('error', name: 'AboutGameScreen', error: e);
    }
  }

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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/play_store_512.png'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: GameSizes.getWidth(0.2),
                        height: GameSizes.getWidth(0.2),
                      ),
                    ),
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
                          'Version 1.0.1',
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
              ),
              OptionGroup(
                options: [
                  OptionWidget(
                    title: 'Visit Developer Website',
                    iconColor: Colors.blue,
                    iconData: Icons.web_asset,
                    onTap: () => launchPage(
                        'https://recepsenoglu.com/'),
                  ),
                ],
              ),
              // OptionGroup(
              //   options: [
              //     OptionWidget(
              //       title: 'Rate Us',
              //       iconColor: Colors.green,
              //       iconData: Icons.star,
              //       onTap: () {},
              //     ),
              //     OptionWidget(
              //       title: 'Share',
              //       iconColor: Colors.blue,
              //       iconData: Icons.share,
              //       onTap: () {},
              //     ),
              //   ],
              // ),
            ],
          ),
        ));
  }
}
