// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:io';
import 'dart:math';

void main() {
  Random rand = new Random();
  int correctAnswer, userAnswer, operand1, operand2, operation;  //all ints
  int questionsAttempted = 0, numCorrect = 0;  //ints initialized
  
  while (true) {
    operation = rand.nextInt(3);  //random number 0, 1, or 2
    operand1 = rand.nextInt(11);  //random number 0-10
    operand2 = rand.nextInt(11);  //random number 0-10
    
    switch (operation) {
      case 0:  //addition question
        print("$operand1 + $operand2 = ");
        correctAnswer = operand1 + operand2;
        break;
      case 1:  //subtraction question
        print("$operand1 - $operand2 = ");
        correctAnswer = operand1 - operand2;
        break;
      case 2:  //multiplication question
        print("$operand1 * $operand2 = ");
        correctAnswer = operand1 * operand2;
        break;
      default:
        break;
    }
   
    String inTemp = stdin.readLineSync();
    
    try {
      userAnswer = int.parse(inTemp);
    } on FormatException {  //uh oh, could not be turned into integer
      print("Thanks for playing!");
      print("You got $numCorrect out of $questionsAttempted correct.");
      break;
    }
    
    if (userAnswer == correctAnswer) {  //right answer?
      numCorrect++;
      print("Correct!");
    } else {
      print("Wrong!");
    }
    
    questionsAttempted++;
  }
}
