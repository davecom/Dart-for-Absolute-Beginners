// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

library wordsearch;

import "dart:html";
import "dart:math";  // for Random, Point
import "package:constrained/constrained.dart";

part "search_word.dart";
part "word_search_constraint.dart";
part "cell.dart";
part "grid.dart";

void main() {  // setup event handlers for buttons
  querySelector("#create").onClick.listen(createWordSearch);
  querySelector("#print").onClick.listen((MouseEvent me) => window.print());
  querySelector("#hide").onClick.listen((MouseEvent me) {
    DivElement controlSection = (querySelector("#input_section") as DivElement);
    controlSection.hidden = !controlSection.hidden;  // just flip it
  });
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
  
  if (gridWidth < 1 || gridHeight < 1) {
    window.alert("The grid must be at least 1 cell long in each dimension.");
    return;
  }

  String inputWordList = (querySelector("#word_list") as TextAreaElement).value;
  if (inputWordList.trim() == "") {
    window.alert("Word List can't be blank.");
    return;
  }
  
  List<String> words = inputWordList.split(",");

  populateGrid(words, gridWidth, gridHeight);  // try to fill in a grid with the words
}

/// Perform a bakcktracking search using constraineD to determine
/// how all of the words can fit in the grid.
void populateGrid(List<String> words, int width, int height) {
  // prepare words for search
  List<SearchWord> searchWords = [];
  Map<SearchWord, List<List<Point>>> domains = {};
  int sumOfWordLengths = 0;
  for (String word in words) {
    SearchWord sw = new SearchWord(word.trim());
    searchWords.add(sw);
    List<List<Point>> tempDomain = sw.getDomain(width, height);
    if (tempDomain.isEmpty) {
      window.alert("The word $word could not fit on the grid.");
      return;
    }

    sumOfWordLengths += sw.word.length;
    tempDomain.shuffle(); // dont' want boring solutions first
    domains[sw] = tempDomain;
  }

  if (sumOfWordLengths > width * height) {
    window.alert("There's not enough room on the grid for those words.");
    return;
  }

  // perform the search
  CSP wordSearchCSP = new CSP(searchWords, domains);
  wordSearchCSP.addListConstraint(new WordSearchConstraint(searchWords));
  backtrackingSearch(wordSearchCSP, {}).then((solution) {

    if (solution == null) {
      window.alert("Could not fit words on grid.");
    } else {
      // create display for grid
      CanvasElement wordSearchCanvas = new CanvasElement();
      wordSearchCanvas.width = width * Cell.WIDTH;
      wordSearchCanvas.height = height * Cell.HEIGHT;
      Grid wordSearchGrid = new Grid(wordSearchCanvas, width, height);

      // get search results and fill in grid
      for (SearchWord sw in solution.keys) {
        for (int i = 0; i < sw.word.length; i++) {
          wordSearchGrid.cells[solution[sw][i]].letter = sw.word[i];
        }
      }

      showGrid(wordSearchCanvas, wordSearchGrid, words);
    }
  });
}

/// Show a window containing the grid, the word list, and a print button
void showGrid(CanvasElement wordSearchCanvas, Grid wordSearchGrid, List<String> words) {
  // clear the output container draw main grid
  DivElement gridContainer = querySelector("#output_section");
  gridContainer.innerHtml = "";
  gridContainer.append(wordSearchCanvas);
  wordSearchGrid.drawOnce();

  // add word list
  UListElement listElement = new UListElement();
  gridContainer.append(listElement);
  for (String word in words) {
    LIElement itemElement = new LIElement();
    listElement.append(itemElement);
    itemElement.text = word.trim().toUpperCase();
  }
}