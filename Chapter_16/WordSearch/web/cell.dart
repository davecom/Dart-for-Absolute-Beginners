// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

part of wordsearch;

class Cell {
  String letter = "";
  Point location;
  
  static const int WIDTH = 20;
  static const int HEIGHT = 20;
  
  Cell(this.location, this.letter);
  
  /// Each Cell can draws itself
  void draw(CanvasRenderingContext2D c2d) { 
    //have a black outline
    c2d.setStrokeColorRgb(0, 0, 0);  // black
    c2d.strokeRect(location.x * WIDTH, location.y * HEIGHT, WIDTH, HEIGHT);
    //draw letter
    c2d.textAlign = "center";  // text is drawn from the middle horizontally
    c2d.textBaseline = "middle";  // text is drawn from the middle vertically
    c2d.strokeText(letter.toUpperCase(), location.x * WIDTH + WIDTH / 2, location.y * HEIGHT + HEIGHT / 2, WIDTH);
    //print("X: ${location.x * WIDTH} Y: ${location.y * HEIGHT}");
  }
}