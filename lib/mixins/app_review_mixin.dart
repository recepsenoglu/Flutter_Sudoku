import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

mixin AppReviewMixin<T extends StatefulWidget> on State<T> {
  final InAppReview inAppReview = InAppReview.instance;
  bool reviewLoading = false;
  void Function()? reviewOnStateChange;

  Future<void> openStoreListing() async {
    reviewLoading = true;
    reviewOnStateChange?.call();
    await inAppReview.openStoreListing();
    reviewLoading = false;
    reviewOnStateChange?.call();
  }
}
