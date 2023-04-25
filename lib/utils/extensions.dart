extension TimeString on int {
  String toTimeString() {
    if (this >= 0) {
      final int minutes = (this / 60).floor();
      final int seconds = this - 60 * minutes;

      return '${minutes < 10 ? '0' : ''}$minutes:${seconds < 10 ? '0' : ''}$seconds';
    }
    return '--:--';
  }
}
