// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

part of wordsearch;

class Grid {
  final int numCellsWide;
  final int numCellsTall;
  CanvasElement wordSearchCanvas;
  Map<Point, Cell> cells = new Map();
  
  Grid(this.wordSearchCanvas, this.numCellsWide, this.numCellsTall) {
    Random r = new Random();
    const String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    // initialize  all the cells
    for (int x = 0; x < numCellsWide; x++) {
      for (int y = 0; y < numCellsTall; y++) {
        Point location = new Point(x, y);
        // fill initially with random letters
        int randLoc = r.nextInt(ALPHABET.length);
        cells[location] = new Cell(location, ALPHABET[randLoc]);
      }
    }
  }
  
  /// Get a cell at a given location by looking it up
  /// in the cells Map.
  Cell getCell(int x, int y) {
    return cells[new Point(x, y)];
  }
  
  /// draw the whole grid once
  void drawOnce() {
    CanvasRenderingContext2D c2d = wordSearchCanvas.context2D;
    c2d.clearRect(0, 0, numCellsWide * Cell.WIDTH, numCellsTall * Cell.HEIGHT);
    for (Cell cell in cells.values) {
      cell.draw(c2d);
    }
  }
  
}