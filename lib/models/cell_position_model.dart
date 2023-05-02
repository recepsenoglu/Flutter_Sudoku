class CellPositionModel {
  final int y;
  final int x;

  CellPositionModel({
    required this.y,
    required this.x,
  });

  int get boxIndex => 3 * (y / 3).floor() + (x / 3).floor();

  String print() => 'y: $y, x: $x,   box: $boxIndex\n';

  factory CellPositionModel.fromJson(Map<String, dynamic> json) {
    return CellPositionModel(
      x: int.parse(json['x']!),
      y: int.parse(json['y']!),
    );
  }

  Map<String, String> toJson() => {'y': '$y', 'x': '$x'};
}
