library wordsearch;

import "dart:html";
import "dart:math";  // for Random, Point
import "dart:async";  // for Future, Timer
import "dart:isolate";
import "package:constrained/constrained.dart";

part "search_word.dart";
part "word_search_constraint.dart";
part "cell.dart";
part "grid.dart";

Grid wordSearchGrid;
CanvasElement wordSearchCanvas;

int width;
int height;

/// Perform a bakcktracking search using constraineD to determine
/// how all of the words can fit in the grid.
void populateGrid(List<String> words) {
  // prepare words for search
  List<SearchWord> searchWords = [];
  Map<SearchWord, List<List<Point>>> domains = {};
  for (String word in words) {
    SearchWord sw = new SearchWord(word.trim());
    searchWords.add(sw);
    List<List<Point>> tempDomain = sw.getDomain(width, height);
    if (tempDomain.isEmpty) {
      window.alert("The word $word could not fit on the grid.");
      return;
    }
    
    tempDomain.shuffle();  // dont' want boring solutions first
    domains[sw] = tempDomain;
  }
  
  // perform the search
  CSP wordSearchCSP = new CSP(searchWords, domains);
  wordSearchCSP.addListConstraint(new WordSearchConstraint(searchWords));
  Map solution = backtrackingSearch(wordSearchCSP, {});
  
  // get search results and fill in grid 
  if (solution == null) {
    window.alert("Could not fit words on grid.");
  } else {
    for (SearchWord sw in solution.keys) {
      for (int i = 0; i < sw.word.length; i++) {
        wordSearchGrid.cells[solution[sw][i]].letter = sw.word[i];
      }
    }
  }
  print(solution);
  wordSearchGrid.drawOnce();
}


/// Get parameters for grid from user and create Grid
void createWordSearch(MouseEvent event) {
  String widthText = (querySelector("#grid_width") as InputElement).value;
  String heightText = (querySelector("#grid_height") as InputElement).value;

  int gridWidth, gridHeight;
  try {
    gridWidth = int.parse(widthText);
    gridHeight = int.parse(heightText); 
  } on FormatException {
    window.alert("Grid's dimensions must be defined with integers.");
    return;
  }
  
  wordSearchCanvas.width = gridWidth * Cell.WIDTH;
  wordSearchCanvas.height = gridHeight * Cell.HEIGHT;
  wordSearchGrid = new Grid(wordSearchCanvas, gridWidth, gridHeight);
  List<String> words = (querySelector("#word_list") as TextAreaElement).value.split(",");
  
  // do actual solution finding asychronously
  width = gridWidth;
  height = gridHeight;
  Isolate.spawn(populateGrid, words);
  /*Future populateFuture = new Future(() {
    populateGrid(words, gridWidth, gridHeight);
  });
  populateFuture.timeout(const Duration(seconds: 3), onTimeout: () {
    window.alert("Could not create a word search in a reasonable amount of time.");
  });*/
  
  // after being done, draw it if one was found
  /*populateFuture.then((junk) {
    wordSearchGrid.drawOnce();
  });*/
}

void main() {
  wordSearchCanvas = querySelector("#word_search_canvas");
  querySelector("#create").onClick.listen(createWordSearch);
}