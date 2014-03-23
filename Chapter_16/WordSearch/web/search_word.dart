// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

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
        // forward up diagonal
        if ((x + word.length <= width) && (y + word.length <= height)) {
          List newPlacement = [];
          for (int i = 0; i < word.length; i++) {
            newPlacement.add(new Point(x + i, y + i));
          }
          domain.add(newPlacement);
        }
        // backwards down diagonal
        if ((x - word.length >= -1) && (y - word.length >= -1)) {
          List newPlacement = [];
          for (int i = 0; i < word.length; i++) {
            newPlacement.add(new Point(x - i, y - i));
          }
          domain.add(newPlacement);
        }
        // forward down diagonal
        if ((x + word.length <= width) && (y - word.length >= -1)) {
          List newPlacement = [];
          for (int i = 0; i < word.length; i++) {
            newPlacement.add(new Point(x + i, y - i));
          }
          domain.add(newPlacement);
        }
        // backwards up diagonal
        if ((x - word.length >= -1) && (y + word.length <= height)) {
          List newPlacement = [];
          for (int i = 0; i < word.length; i++) {
            newPlacement.add(new Point(x - i, y + i));
          }
          domain.add(newPlacement);
        }
      }
    }

    return domain;
  }
}