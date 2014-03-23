// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

part of wordsearch;

class WordSearchConstraint extends ListConstraint {
  WordSearchConstraint(List words): super(words);

  /// This constraint is satisfied when no words overlap in the grid
  @override
  bool isSatisfied(Map assignment) {
    List allPointsUsed = [];
    for (List<Point> wordPlaces in assignment.values) {
      allPointsUsed.addAll(wordPlaces);
    }
    Set allPointsUsedSet = allPointsUsed.toSet();
    if (allPointsUsedSet.length < allPointsUsed.length) {  // duplicates check
      return false;  // must be an overlap of words
    } else {
      return true;
    }
  }
}
