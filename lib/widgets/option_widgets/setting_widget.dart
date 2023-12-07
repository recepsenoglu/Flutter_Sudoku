import 'package:flutter/cupertino.dart';

import '../../utils/game_colors.dart';
import '../../utils/game_sizes.dart';
import '../../utils/game_text_styles.dart';

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
      padding: GameSizes.getHorizontalPadding(0.01),
      child: Row(
        children: [
          SizedBox(width: GameSizes.getWidth(0.015)),
          Text(title,
              style: GameTextStyles.settingButtonTitle
                  .copyWith(fontSize: GameSizes.getWidth(0.04))),
          const Spacer(),
          SizedBox(
            height: GameSizes.getHeight(0.04),
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
