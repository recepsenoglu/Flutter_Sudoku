import 'package:flutter/cupertino.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_text_styles.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final bool value;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          const SizedBox(width: 6),
          Text(
            title,
            style: GameTextStyles.settingButtonTitle,
          ),
          const Spacer(),
          SizedBox(
            height: 38,
            child: CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: GameColors.switchOn,
            ),
          )
        ],
      ),
    );
  }
}
