import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/useful_tip_model.dart';

class UsefulTips {
  static UsefulTipModel getRandomUsefulTip() {
    _getUsefulTips.shuffle();
    return _getUsefulTips[0];
  }

  static final List<UsefulTipModel> _getUsefulTips = [
    UsefulTipModel(
      title: "statistics".tr(),
      description: "statisticsTip".tr(),
      iconData: Icons.bar_chart,
      color: Colors.blue,
    ),
    UsefulTipModel(
      title: "settings".tr(),
      description: "settingsTip".tr(),
      iconData: Icons.settings,
      color: Colors.green,
    ),
    UsefulTipModel(
      title: "difficulty".tr(),
      description: "difficultyTip".tr(),
      iconData: Icons.gamepad,
      color: Colors.red,
    ),
    UsefulTipModel(
      title: "timer".tr(),
      description: "timerTip".tr(),
      iconData: Icons.timer,
      color: Colors.orange,
    ),
    UsefulTipModel(
      title: "notes".tr(),
      description: "notesTip".tr(),
      iconData: Icons.notes,
      color: Colors.purple,
    ),
    UsefulTipModel(
      title: "mistakes".tr(),
      description: "mistakesTip".tr(),
      iconData: Icons.error,
      color: Colors.redAccent,
    ),
  ];
}
