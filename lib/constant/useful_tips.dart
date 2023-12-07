import 'package:flutter/material.dart';

import '../models/useful_tip_model.dart';

class UsefulTips {
  static UsefulTipModel getRandomUsefulTip() {
    _getUsefulTips.shuffle();
    return _getUsefulTips[0];
  }

  static final List<UsefulTipModel> _getUsefulTips = [
    UsefulTipModel(
      title: 'Statistics',
      description: 'Easily track your progress with detailed statistics',
      iconData: Icons.bar_chart,
      color: Colors.blue,
    ),
    UsefulTipModel(
      title: 'Settings',
      description: 'Make the game more comfortable for you',
      iconData: Icons.settings,
      color: Colors.green,
    ),
    UsefulTipModel(
      title: 'Difficulty',
      description: 'Play with different difficulties',
      iconData: Icons.gamepad,
      color: Colors.red,
    ),
    UsefulTipModel(
      title: 'Timer',
      description: 'Try to solve the puzzle as fast as you can',
      iconData: Icons.timer,
      color: Colors.orange,
    ),
    UsefulTipModel(
      title: 'Notes',
      description: 'Use notes to solve the puzzle faster',
      iconData: Icons.notes,
      color: Colors.purple,
    ),
    UsefulTipModel(
      title: 'Mistakes',
      description: 'Try to solve the puzzle without mistakes',
      iconData: Icons.error,
      color: Colors.redAccent,
    ),
  ];
}
