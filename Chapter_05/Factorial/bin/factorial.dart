// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:io';

/// Calculate n! recursively.
int factorial(int n) {
  if (n <= 1) {  //base case
    return 1;
  }
  return n * factorial(n - 1);  //recursive case
}

/// Calculate n! with a for-loop
int factorial2(int n) {
  int total = 1;
  for (int i = n; i > 0; i--) {  //working backwards
    total *= i;
  }
  return total;
}

void main() {
  int n;
  
  print("What factorial do you want to calculate??");
  String inTemp = stdin.readLineSync();
  
  try {
    n = int.parse(inTemp);
  } on FormatException {  //uh oh, could not be turned into integer
    print("That was not an integer.");
    return;
  }
  
  if (n <= 0) {  //check for bad input
    print("That's not a positive integer!");
    return;
  }
  
  print("n! = ${factorial(n)} calculated recursively.");
  print("n! = ${factorial2(n)} calculated iteratively.");
}