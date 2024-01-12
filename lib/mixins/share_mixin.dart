import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

mixin ShareMixin<T extends StatefulWidget> on State<T> {
  bool shareLoading = false;
  void Function()? onStateChange;

  Future<void> shareApp(String text) async {
    shareLoading = true;
    onStateChange?.call();
    await Share.share(text);
    shareLoading = false;
    onStateChange?.call();
  }
}
