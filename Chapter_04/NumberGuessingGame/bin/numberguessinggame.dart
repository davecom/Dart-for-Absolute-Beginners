// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:math';
import 'dart:io';

void main() {
  int guess;
  Random rand = new Random();  //create a random number generator
  int answer = rand.nextInt(100);  //gets a random integer from 0 to 99
  do {
    print("Enter your guess:");
    String temp = stdin.readLineSync();  //read in from the keyboard
    guess = int.parse(temp);  //convert string to integer
    if (guess < answer) {
      print("Too low!");
    } else if (guess > answer) {
      print("Too high!");
    }
  } while (guess != answer);
  print("You got it!");
}
