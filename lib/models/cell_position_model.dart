class CellPositionModel {
  final int x;
  final int y;

  CellPositionModel({
    required this.x,
    required this.y,
  });

  int get boxIndex => y + (x / 3).floor();
}
