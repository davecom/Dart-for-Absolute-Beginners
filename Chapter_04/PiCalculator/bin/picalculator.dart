// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:math';

void main() {
  const int ITERATIONS = 100000;  //the higher the more accurate
  double series = 1.0;
  double denominator = 3.0;
  double negate = -1.0;
  
  for (int i = 0; i < ITERATIONS; i++) {
    series += (negate * (1 / denominator));
    denominator += 2.0;
    negate *= -1.0;
  }
  
  double pi = 4 * series;
  print("We calculated pi as $pi");
  print("The real pi is $PI");
  print("We were off by ${(PI - pi).abs()}");
}
