
import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    required this.title,
    required this.iconData,
    required this.iconColor,
    this.onTap,
    super.key,
  });

  final String title;
  final IconData iconData;
  final Color iconColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 34,
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: AppTextStyles.optionButtonTitle,
          ),
          const Spacer(),
          Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.greyColor,
          ),
        ],
      ),
    );
  }
}
