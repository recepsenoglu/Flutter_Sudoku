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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  days.length,
                  (index) {
                    return SizedBox(
                      width: 10,
                      child: Text(
                        days[index],
                        textAlign: TextAlign.center,
                        style: AppTextStyles.calendarDays,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.count(
                crossAxisCount: 7,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                children: List.generate(
                  35,
                  (index) {
                    final int day = index - firstDayOfMonth + 1;
                    final bool isFuture = day > now.day;
                    final bool isCurrentMonth = index >= firstDayOfMonth;
                    final bool isCompleted = day == 8;
                    final bool isStarted = isCurrentMonth && day % 2 == 0;
                    final bool isSelected =
                        isCurrentMonth && !isFuture && day % 3 == 0;

                    if (isCompleted) {
                      return const StarBadgeWidget();
                    }

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          decoration: getDecoration(isSelected),
                          child: Center(
                            child: Text(
                              isCurrentMonth ? '$day' : '',
                              style: isFuture
                                  ? AppTextStyles.calendarFutureDate
                                  : isSelected
                                      ? AppTextStyles.calendarDateSelected
                                      : AppTextStyles.calendarDate,
                            ),
                          ),
                        ),
                        getProgressIndicator(isStarted, isSelected),
                      ],
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

  BoxDecoration? getDecoration(bool isSelected) {
    return isSelected
        ? BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.roundedButton,
          )
        : null;
  }

  Widget getProgressIndicator(bool isStarted, bool isSelected) {
    if (isStarted) {
      return Padding(
        padding: EdgeInsets.all(isSelected ? 4 : 2),
        child: CircularProgressIndicator(
          value: 0.4,
          strokeWidth: 3,
          color: isSelected ? Colors.white : AppColors.roundedButton,
          backgroundColor: isSelected
              ? AppColors.progressBgSelected
              : AppColors.lightGreyColor,
        ),
      );
    }
    return const SizedBox();
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
