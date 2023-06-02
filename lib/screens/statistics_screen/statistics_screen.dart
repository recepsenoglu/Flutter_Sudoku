import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/constant/game_constants.dart';
import 'package:flutter_sudoku/models/stat_group_model.dart';
import 'package:flutter_sudoku/models/stat_model.dart';
import 'package:flutter_sudoku/screens/statistics_screen/statistics_screen_provider.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';
import 'package:flutter_sudoku/widgets/appbar_action_button.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Difficulty> difficulties = GameSettings.getDifficulties;

    return DefaultTabController(
      length: difficulties.length,
      child: ChangeNotifierProvider<StatisticsScreenProvider>(
        create: (context) => StatisticsScreenProvider(),
        child:
            Consumer<StatisticsScreenProvider>(builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar:
                StatisticsAppBar(onTimeInterval: provider.changeTimeInterval),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (provider.loading) ...[
                  const Center(child: CupertinoActivityIndicator()),
                ] else
                  Expanded(
                    child: TabBarView(
                      children: List.generate(
                        difficulties.length,
                        (index) => Statistics(
                          provider: provider,
                          statGroupModel:
                              provider.getStatGroup(difficulties[index]),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class Statistics extends StatelessWidget {
  const Statistics({
    required this.statGroupModel,
    required this.provider,
    super.key,
  });

  final StatGroupModel statGroupModel;
  final StatisticsScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          GameSettings.getStatisticTypes.length,
          (index) {
            StatisticType statisticType = GameSettings.getStatisticTypes[index];

            return StatisticsGroup(
              groupTitle: statisticType.name,
              statistics: statGroupModel.getStats(statisticType),
            );
          },
        ),
      ),
    );
  }
}

class StatisticsGroup extends StatelessWidget {
  const StatisticsGroup({
    required this.groupTitle,
    required this.statistics,
    super.key,
  });

  final String groupTitle;
  final List<StatModel> statistics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            groupTitle,
            style: AppTextStyles.statisticsGroupTitle,
          ),
          const SizedBox(height: 6),
          Column(
            children: List.generate(
              statistics.length,
              (index) {
                return StatisticCard(statModel: statistics[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  const StatisticCard({
    required this.statModel,
    super.key,
  });

  final StatModel statModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: AppColors.statisticsCard,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                getIcon(statModel.title),
                color: AppColors.roundedButton,
                size: 28,
              ),
              const SizedBox(height: 14),
              Text(
                statModel.title,
                style: AppTextStyles.statisticsCardTitle,
              ),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const ComparisonBox(),
              Text(
                statModel.value == null ? '-' : statModel.value.toString(),
                style: AppTextStyles.statisticsCardValue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData getIcon(String title) {
    switch (title) {
      case Strings.gamesStarted:
        return Icons.grid_on_rounded;
      case Strings.gamesWon:
        return Icons.workspace_premium_rounded;
      case Strings.winRate:
        return Icons.outlined_flag_sharp;
      case Strings.winsWithNoMistakes:
        return Icons.sports_score_outlined;
      case Strings.bestTime:
        return Icons.timer;
      case Strings.averageTime:
        return Icons.timelapse_sharp;
      case Strings.bestScore:
        return Icons.star;
      case Strings.averageScore:
        return Icons.star_border_purple500;
      case Strings.currentWinStreak:
        return Icons.keyboard_double_arrow_right_rounded;
      case Strings.bestWinStreak:
        return Icons.double_arrow_sharp;
      default:
        return Icons.grid_on_rounded;
    }
  }
}

class ComparisonBox extends StatelessWidget {
  const ComparisonBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool positive = true;
    IconData arrowIcon = positive ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: positive ? AppColors.statisticsUp : AppColors.statisticsDown,
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        children: [
          Icon(
            arrowIcon,
            color: Colors.white,
            size: 16,
          ),
          Text(
            '12',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class StatisticsAppBar extends StatelessWidget with PreferredSizeWidget {
  const StatisticsAppBar({
    required this.onTimeInterval,
    super.key,
  });

  final Function() onTimeInterval;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      backgroundColor: AppColors.appBarBackground,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Text(Strings.statistics, style: AppTextStyles.statisticsTitle),
      leading: const SizedBox.shrink(),
      actions: [
        AppBarActionButton(
          icon: Icons.settings,
          onPressed: onTimeInterval,
        ),
      ],
      bottom: TabBar(
          labelColor: AppColors.roundedButton,
          unselectedLabelColor: AppColors.greyColor,
          labelStyle:
              const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold),
          indicatorColor: Colors.transparent,
          isScrollable: true,
          tabs: List.generate(
              GameSettings.getDifficulties.length,
              (index) => Tab(
                      child: Text(
                    GameSettings.getDifficulties[index].name,
                    textAlign: TextAlign.left,
                  )))),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
