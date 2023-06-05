import 'package:flutter/material.dart';

class AppSizes {
  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).viewPadding.top;
  }
}
