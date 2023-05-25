import 'package:flutter/material.dart';
import 'package:flutter_sudoku/constant/enums.dart';
import 'package:flutter_sudoku/models/statistics_model.dart';
import 'package:flutter_sudoku/services/storage_service.dart';
import 'package:flutter_sudoku/widgets/modal_bottom_sheet/modal_bottom_sheets.dart';

class StatisticsScreenProvider with ChangeNotifier {
  late StorageService _storageService;
  late StatisticsModel statisticsModel;

  bool loading = true;

  TimeInterval timeInterval = TimeInterval.All_time;

  StatisticsScreenProvider() {
    _init();
  }

  Future<void> _init() async {
    _storageService = await StorageService.initialize();
    _getAllStatistics();

    loading = false;
    notifyListeners();
  }

  void _getAllStatistics() {
    statisticsModel = StatisticsModel(statistics: []);

    for (Difficulty difficulty in Difficulty.values) {
      StatisticsModel? statistics = _storageService.getStatistics(difficulty);
      if (statistics != null) {
        statisticsModel.statistics.addAll(statistics.statistics);
      }
    }

    print(statisticsModel);
  }

  Future<void> changeTimeInterval() async {
    TimeInterval? selectedTimeInterval =
        await ModalBottomSheets.chooseTimeInterval(timeInterval);

    if (selectedTimeInterval != null) {
      timeInterval = selectedTimeInterval;
      notifyListeners();
    }
  }
}
