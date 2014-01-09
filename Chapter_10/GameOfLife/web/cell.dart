// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

part of life;  // gotta love this opening

class Cell {
  bool alive = false;
  bool aliveNextGeneration = false;
  Point location;
  
  static const int WIDTH = 20;
  static const int HEIGHT = 20;
  
  Cell(this.location);
  
  /// Each Cell can draws itself
  void draw(CanvasRenderingContext2D c2d) {
    if (alive) {  // fill living cells blue
      c2d.setFillColorRgb(0, 0, 255);  // blue
    } else {  // fill dead cells white
      c2d.setFillColorRgb(255, 255, 255);  // white
    }
    c2d.fillRect(location.x * WIDTH, location.y * HEIGHT, WIDTH, HEIGHT);
    
    //have a black outline
    c2d.setStrokeColorRgb(0, 0, 0);  // black
    c2d.strokeRect(location.x * WIDTH, location.y * HEIGHT, WIDTH, HEIGHT);
  }
}