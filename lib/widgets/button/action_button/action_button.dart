import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_text_styles.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.title,
    required this.iconWidget,
    required this.onTap,
    super.key,
  });

  final String title;
  final Widget iconWidget;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              iconWidget,
              const SizedBox(height: 6),
              Text(
                title,
                style: AppTextStyles.actionButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
