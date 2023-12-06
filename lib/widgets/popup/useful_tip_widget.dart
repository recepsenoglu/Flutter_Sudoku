import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';

class UsefulTipWidget extends StatelessWidget {
  const UsefulTipWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        decoration: BoxDecoration(
          color: GameColors.usefulTipBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.stacked_bar_chart,
              size: 42,
              color: Colors.blue,
            ),
            const SizedBox(height: 14),
            Text(
              'Statistics',
              style: TextStyle(
                color: GameColors.usefulTipTitle,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Each puzzle solved improves your statistics!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: GameColors.usefulTipContent,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
