import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/constant/constants.dart';
import 'package:flutter_sudoku/screens/daily_challenges_screen/daily_challenges_screen_provider.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/app_sizes.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';
import 'package:flutter_sudoku/widgets/button/rounded_button/rounded_button.dart';
import 'package:flutter_sudoku/widgets/star_badge_widget.dart';
import 'package:provider/provider.dart';

class DailyChallengesScreen extends StatelessWidget {
  const DailyChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DailyChallengesScreenProvider>(
      create: (context) => DailyChallengesScreenProvider(),
      child: Consumer<DailyChallengesScreenProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.dailyChallengesScreenBg,
            body: Column(
              children: [
                const TopBlueBox(),
                const CalendarWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RoundedButton(
                    buttonText: Strings.play,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 36),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    final int firstDayOfMonth = now.copyWith(day: 1).weekday;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${months[now.month - 1]} ${now.year}',
                  style: AppTextStyles.calendarDateTitle,
                ),
                const Spacer(),
                const StarBadgeWidget(),
                const SizedBox(width: 8),
                Text(
                  '0/30',
                  style: AppTextStyles.calendarDateTitle,
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: List.generate(
                days.length,
                (index) {
                  return Expanded(
                    child: Text(
                      days[index],
                      textAlign: TextAlign.center,
                      style: AppTextStyles.calendarDays,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                children: List.generate(
                  35,
                  (index) {
                    final int day = index - firstDayOfMonth + 1;
                    final bool isFuture = day > now.day;
                    final bool isCurrentMonth = index >= firstDayOfMonth;

                    return Center(
                      child: Text(
                        isCurrentMonth ? '$day' : '',
                        style: isFuture
                            ? AppTextStyles.calendarFutureDate
                            : AppTextStyles.calendarDate,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopBlueBox extends StatelessWidget {
  const TopBlueBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: AppSizes.statusBarHeight(context),
      ),
      decoration: BoxDecoration(color: Colors.blue.shade700),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Text(
            Strings.dailyChallenges,
            style: AppTextStyles.dailyChallengesTitle,
          ),
        ],
      ),
    );
  }
}
