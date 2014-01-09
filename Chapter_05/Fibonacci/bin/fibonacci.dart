// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:io';

/// Find the nth term in the Fibonacci sequence
int fib(int n) {
  if (n < 2) {  //base case
    return n;
  }
  return fib(n - 2) + fib(n - 1);  //recursive case
}

void main() {
  int n;
  
  print("What n do you want to lookup in the Fibonacci sequence?");
  String inTemp = stdin.readLineSync();
  
  try {
    n = int.parse(inTemp);
  } on FormatException {  //uh oh, could not be turned into integer
    print("That was not an integer.");
    return;
  }
  
  print("fib($n) = ${fib(n)}");
}