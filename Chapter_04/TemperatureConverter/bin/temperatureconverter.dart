// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:io';

void main() {
  print("A:Convert Celsius to Fahrenheit\nB:Convert Fahrenheit to Celsius");
  String selection;
  
  do {
    selection = stdin.readLineSync().toUpperCase();  //get uppercase input
  } while (selection != "A" && selection != "B");  //think of && like AND
  
  print("Enter the starting temperature:");
  String inTemp = stdin.readLineSync();
  int temp = int.parse(inTemp);
  
  switch (selection) {
    case "A":
      print("$temp degrees Celsius is ${temp * 1.8 + 32} degrees Fahrenheit");
      break;
    case "B":
      print("$temp degrees Fahrenheit is ${(temp - 32) / 1.8} degrees Celsius");
      break;
    default:
      break;
  }
}
