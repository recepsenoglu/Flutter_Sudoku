import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/app_colors.dart';
import 'package:flutter_sudoku/utils/text_styles.dart';

class OptionGroup extends StatelessWidget {
  const OptionGroup({
    required this.options,
    this.fullDivider = false,
    this.groupDescription,
    super.key,
  });

  final List<Widget> options;
  final bool fullDivider;
  final String? groupDescription;

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: List.generate(
              options.length,
              (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 5),
                      child: options[index],
                    ),
                    Visibility(
                      visible: index < options.length - 1,
                      child: Container(
                        height: 0.4,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: fullDivider ? 16 : 57),
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        if (groupDescription != null) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              groupDescription!,
              style: AppTextStyles.optionGroupDescription,
            ),
          ),
        ],
        SizedBox(height: groupDescription != null ? 4 : 12),
      ],
    );
  }
}
