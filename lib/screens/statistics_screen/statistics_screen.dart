import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/constant/game_constants.dart';
import 'package:flutter_sudoku/models/statistic_model.dart';
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
            body: TabBarView(
                children: List.generate(
                    difficulties.length,
                    (index) => Statistics(
                        difficulty: difficulties[index], provider: provider))),
          );
        }),
      ),
    );
  }
}

class Statistics extends StatelessWidget {
  const Statistics({
    required this.difficulty,
    required this.provider,
    super.key,
  });

  final Difficulty difficulty;
  final StatisticsScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatisticsGroup(
            title: Strings.games,
            statistics: [
              StatisticModel(title: 'Games Started', value: 10),
              StatisticModel(title: 'Games Won', value: 7),
            ],
          ),
          StatisticsGroup(
            title: Strings.time,
            statistics: [
              StatisticModel(title: 'Best Time', value: 10),
              StatisticModel(title: 'Average Time', value: 7),
            ],
          ),
        ],
      ),
    );
  }
}

class StatisticsGroup extends StatelessWidget {
  const StatisticsGroup({
    required this.title,
    required this.statistics,
    super.key,
  });

  final String title;
  final List<StatisticModel> statistics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.statisticsGroupTitle,
          ),
          const SizedBox(height: 6),
          Column(
            children: List.generate(
              statistics.length,
              (index) {
                return StatisticCard(statisticModel: statistics[index]);
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
    required this.statisticModel,
    super.key,
  });

  final StatisticModel statisticModel;

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
                Icons.grid_on_rounded,
                color: AppColors.roundedButton,
                size: 28,
              ),
              const SizedBox(height: 14),
              Text(
                statisticModel.title,
                style: AppTextStyles.statisticsCardTitle,
              ),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ComparisonBox(),
              Text(
                statisticModel.value.toString(),
                style: AppTextStyles.statisticsCardValue,
              ),
            ],
          ),
        ],
      ),
    );
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
