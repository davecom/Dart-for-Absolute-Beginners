// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

library life;

import 'dart:html';
import 'dart:math';  // for Point
import 'dart:async'; // for Timer

part "cell.dart";
part "grid.dart";

Timer timer;
Grid grid;

/// When the canvas is clicked, we need to flip a cell
void clickHappened(MouseEvent me) {
  int clickX = me.offset.x;
  int clickY = me.offset.y;
  grid.flip(clickX, clickY);
}

/// Start or stop the Timer from calling update on grid
void startStopTimer(MouseEvent me) {
  if (timer == null) {
    timer = new Timer.periodic(const Duration(seconds:1), grid.update);
    querySelector("#startStop").text = "Stop";
  } else {
    timer.cancel();
    timer = null;
    querySelector("#startStop").text = "Start";
  }
}

void main() {
  CanvasElement lifeCanvas = querySelector("#lifeCanvas");
  // setup grid
  grid = new Grid(lifeCanvas);
  grid.drawOnce();
  lifeCanvas.onClick.listen(clickHappened);
  querySelector("#startStop").onClick.listen(startStopTimer);
}