part of wordsearch;

class SearchWord {
  String word;
  SearchWord(this.word);

  /// Returns all possible positioning of [word] within
  /// a [width] x [height] grid
  List<List<Point>> getDomain(int width, int height) {
    List<List<Point>> domain = [];

    // go through every place in the grid
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        // forward
        if (x + word.length <= width) {
          List newPlacement = [];
          for (int i = 0; i < word.length; i++) {
            newPlacement.add(new Point(x + i, y));
          }
          domain.add(newPlacement);
        }
        // backwards
        if (x - word.length >= -1) { // 0 counts as a place
          List newPlacement = [];
          for (int i = 0; i < word.length; i++) {
            newPlacement.add(new Point(x - i, y));
          }
          domain.add(newPlacement);
        }
        // down
        if (y + word.length <= height) {
          List newPlacement = [];
          for (int i = 0; i < word.length; i++) {
            newPlacement.add(new Point(x, y + i));
          }
          domain.add(newPlacement);
        }
        // up
        if (y - word.length >= -1) { // 0 counts as a place
          List newPlacement = [];
          for (int i = 0; i < word.length; i++) {
            newPlacement.add(new Point(x, y - i));
          }
          domain.add(newPlacement);
        }
        // forward diagonal
        if ((x + word.length <= width) && (y + word.length <= height)) {
          List newPlacement = [];
          for (int i = 0; i < word.length; i++) {
            newPlacement.add(new Point(x + i, y + i));
          }
          domain.add(newPlacement);
        }
        // backwards diagonal
        if ((x - word.length >= -1) && (y - word.length >= -1)) {
          List newPlacement = [];
          for (int i = 0; i < word.length; i++) {
            newPlacement.add(new Point(x - i, y - i));
          }
          domain.add(newPlacement);
        }
      }
    }

    return domain;
  }
}
