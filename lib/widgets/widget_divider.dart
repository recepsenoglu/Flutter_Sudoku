import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';

class WidgetDivider extends StatelessWidget {
  const WidgetDivider(
      {required this.children, this.leftPadding = 0, super.key});

  final List<Widget> children;
  final double leftPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(children.length * 2 - 1, (index) {
        if (index % 2 == 0) {
          return children[(index / 2).floor()];
        } else {
          return Container(
            height: 0.9,
            margin: EdgeInsets.only(left: leftPadding),
            width: double.infinity,
            color: AppColors.divider,
          );
        }
      }),
    );
  }
}
