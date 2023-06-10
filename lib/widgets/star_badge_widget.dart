import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';

class StarBadgeWidget extends StatelessWidget {
  const StarBadgeWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.starBadgeBg,
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        child: Icon(
          Icons.star,
          // size: 14,
          color: AppColors.starBadgeStar,
        ),
      ),
    );
  }
}
