import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/screens/win_screen/win_screen_provider.dart';
import 'package:flutter_sudoku/services/routes.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/app_sizes.dart';
import 'package:flutter_sudoku/utils/app_strings.dart';
import 'package:flutter_sudoku/utils/app_text_styles.dart';
import 'package:flutter_sudoku/widgets/button/rounded_button/rounded_button.dart';
import 'package:provider/provider.dart';

class WinScreen extends StatelessWidget {
  const WinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WinScreenProvider>(
      create: (context) => WinScreenProvider(),
      child: Consumer<WinScreenProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.winScreenBg,
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSizes.statusBarHeight(context)),
                  const SizedBox(height: 30),
                  Text(
                    AppStrings.levelCompleted,
                    style: AppTextStyles.winScreenHeader,
                  ),
                  const MiniSudokuBoard(),
                  const Spacer(),
                  const LevelStatistics(),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: RoundedButton(
                      buttonText: AppStrings.newGame,
                      onPressed: () => provider.newGame(),
                      whiteButton: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Routes.goTo(Routes.navigationBar),
                    child: Text(
                      AppStrings.main,
                      style: AppTextStyles.mainTextButton,
                    ),
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

class LevelStatistics extends StatelessWidget {
  const LevelStatistics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.statistics,
                style: AppTextStyles.levelStatisticsTitle,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.translucentWhite,
                ),
                child: Text(
                  AppStrings.seeAll,
                  style: AppTextStyles.seeAll,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.translucentWhite,
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      ],
    );
  }
}

class MiniSudokuBoard extends StatelessWidget {
  const MiniSudokuBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      width: 235,
      margin: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
