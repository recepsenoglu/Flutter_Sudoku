import 'package:flutter/material.dart';

class SettingsScreenProvider with ChangeNotifier {
  bool switchValue = true;

  void changeValue(bool value) {
    switchValue = value;
    notifyListeners();

    debugPrint('newValue: $value');
  }
}
