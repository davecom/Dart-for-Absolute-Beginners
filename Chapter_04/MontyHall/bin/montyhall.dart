// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:math';

void main() {
  const int TRIALS = 1000000;
  int correct = 0;
  Random rand = new Random();
  for (int i = 0; i < TRIALS; i++) {
    int randDoor = rand.nextInt(3) + 1;  //random door 1 to 3
    int guess = 1;  //we guess door 1
    int eliminated;
    
    if (randDoor == 2) {
      eliminated = 3;  //door 3 eliminated
    } else if(randDoor == 3) {
      eliminated = 2;  //door 2 eliminated
    } else {  //randDoor must be 1
      eliminated = rand.nextInt(2) + 2;  //door 2 or 3 randomly eliminated
    }
    
    if (eliminated == 2) {
      guess = 3;  //switch our guess to door 3
    } else {  //eliminated must be 3
      guess = 2;  //switch our guess to door 2
    }
    
    if (guess == randDoor) {
      correct++;
    }
  }
  print("The percentage of correct guesses was ${(correct / TRIALS) * 100}%");
}
