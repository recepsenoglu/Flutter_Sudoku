import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/app_strings.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';

class HintsAmountCircle extends StatelessWidget {
  const HintsAmountCircle({
    required this.hints,
    super.key,
  });

  final int hints;

  @override
  Widget build(BuildContext context) {
    String hintText = hints > 0 ? hints.toString() : Strings.ad;

    return Positioned(
      right: 6,
      top: 0,
      child: Container(
        width: 26,
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.actionInfoBg,
          ),
          child: Center(
            child: Text(
              hintText,
              style: TextStyle(
                color: AppColors.actionInfoText,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    );
  
  }
}
