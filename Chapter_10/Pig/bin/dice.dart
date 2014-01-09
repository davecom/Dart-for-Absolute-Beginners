// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

part of pig;

class Dice {
  int _sides;
  int _numberOfDice;
  List<int> _values = [];
  
  int get maximumValue => sides * numberOfDice;
  int get numberOfDice => _numberOfDice;
  int get sides => _sides;
  /// total is the sum of [_values]
  int get total => _values.fold(0, (first, second) => first + second);
  
  /// constructs a new Dice object
  Dice(this._sides, this._numberOfDice);
  
  /// generate random values for [_values]
  void roll() {
    List newValues = [];
    Random rand = new Random();
    for (int i = 0; i < numberOfDice; i++) {
      newValues.add(rand.nextInt(sides) + 1);  // number from 1 to sides
    }
    _values = newValues;
  }

  /// print the values of the dice
  void printDice() => print(_values);
}