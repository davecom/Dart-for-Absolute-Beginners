// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import "dart:html";

class Board {
  List<String> _boxes = new List.filled(9, null);  // List of length 9 filled with null
  String _turn = "X";  // X always starts
  
  /// Returns the winning letter if there is one, or null if not
  String get winner {  // check all 3-in-a-rows
    if ((_boxes[0] != null) && ((_boxes[0] == _boxes[1]) && (_boxes[1] == _boxes[2]))) {
      return _boxes[0];
    } else if ((_boxes[0] != null) && ((_boxes[0] == _boxes[3]) && (_boxes[3] == _boxes[6]))) {
      return _boxes[0];
    } else if ((_boxes[1] != null) && ((_boxes[1] == _boxes[4]) && (_boxes[4] == _boxes[7]))) {
      return _boxes[1];
    } else if ((_boxes[2] != null) && ((_boxes[2] == _boxes[5]) && (_boxes[5] == _boxes[8]))) {
      return _boxes[2];
    } else if ((_boxes[3] != null) && ((_boxes[3] == _boxes[4]) && (_boxes[4] == _boxes[5]))) {
      return _boxes[3];
    } else if ((_boxes[6] != null) && ((_boxes[6] == _boxes[7]) && (_boxes[7] == _boxes[8]))) {
      return _boxes[6];
    } else if ((_boxes[0] != null) && ((_boxes[0] == _boxes[4]) && (_boxes[4] == _boxes[8]))) {
      return _boxes[0];
    } else if ((_boxes[2] != null) && ((_boxes[2] == _boxes[4]) && (_boxes[4] == _boxes[6]))) {
      return _boxes[2];
    } else {
      return null;
    }
  }
  
  /// Returns true if position is a draw, false otherwise
  bool get isDraw => !_boxes.contains(null) && winner == null;
  
  /// Returns a List<int> containing open squares
  List<int> get legalMoves {
    List<int> legalMoves = new List();
    for (int i = 0; i < _boxes.length; i++) {
      if (_boxes[i] == null) {
        legalMoves.add(i);
      }
    }
    return legalMoves;
  }
  
  /// Attempts to make [move], returns if could be made or not as bool
  bool makeMove(int move) {
    if (move < 0 || move > _boxes.length) {  // only 0-8 are legal
      throw new RangeError.range(move, 0, _boxes.length);
    }
    if (_boxes[move] == null) {  // can only play where no prior move
      _boxes[move] = _turn;
      _turn = _turn == "O" ? "X" : "O";  // flip _turn
      return true;
    } else {
      return false;
    }
  }
  
  /// Draws current position on myCanvas, respecting width/height
  void draw(CanvasElement myCanvas) {
    CanvasRenderingContext2D myCanvasContext = myCanvas.context2D;
    //draw the background
    myCanvasContext.setFillColorRgb(0, 0, 0);  // Black
    myCanvasContext.moveTo(myCanvas.width / 3, 0);
    myCanvasContext.lineTo(myCanvas.width / 3, myCanvas.height);
    myCanvasContext.moveTo((myCanvas.width / 3) * 2, 0);
    myCanvasContext.lineTo((myCanvas.width / 3) * 2, myCanvas.height);
    myCanvasContext.moveTo(0, myCanvas.height / 3);
    myCanvasContext.lineTo(myCanvas.width, myCanvas.height / 3);
    myCanvasContext.moveTo(0, (myCanvas.height / 3) * 2);
    myCanvasContext.lineTo(myCanvas.width, (myCanvas.height / 3) * 2);
    myCanvasContext.stroke();
    // draw the letter for each box, if one exists
    for (int i = 0; i < _boxes.length; i++) {
      if (_boxes[i] != null) {
        num letterX = myCanvas.width / 6;
        if (i % 3 == 1) {
          letterX = myCanvas.width / 2;
        } else if (i % 3 == 2) {
          letterX = myCanvas.width / 6 * 5;
        }
        num letterY = myCanvas.height / 6;
        if (i > 5) {
          letterY = myCanvas.height / 6 * 5;
        } else if (i > 2) {
          letterY = myCanvas.height / 2;
        }
        myCanvasContext.fillText(_boxes[i], letterX, letterY);  // string, x, y
      }
    }
  }
}