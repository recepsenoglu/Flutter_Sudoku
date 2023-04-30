import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/widgets/modal_bottom_sheet/modal_bottom_sheets.dart';

class StatisticsScreenProvider with ChangeNotifier {
  TimeInterval timeInterval = TimeInterval.All_time;

  Future<void> changeTimeInterval() async {
    TimeInterval? selectedTimeInterval =
        await ModalBottomSheets.chooseTimeInterval(timeInterval);

    if (selectedTimeInterval != null) {
      timeInterval = selectedTimeInterval;
      notifyListeners();
    }
  }
}
