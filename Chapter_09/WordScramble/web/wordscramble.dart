// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:html';
import 'dart:async';

String secretWord;
int numCorrect = 0;
int numMissed = 0;
int secondsLeft = 60;
List wordList = ["ANTELOPE", "ARKANSAS", "AWESOME", "PICKLE", "CEILING",
                 "SUPREME", "CAREFUL", "WRITING", "FUNHOUSE", "FOREVER"];

/// Check if the user has entered the de-scrambled word
void checkGuess(Event e) {
  String guess = (querySelector("#guess") as InputElement).value.toUpperCase();
  if (guess == secretWord) {  // player got it right
    numCorrect++;
    querySelector("#num_correct").text = numCorrect.toString();
    newWord();
  }
}

/// Once a second update the time display and check if
/// the player has run out of time
void tick(Timer t) {
  secondsLeft--;
  querySelector("#seconds_left").text = secondsLeft.toString();
  if (secondsLeft <= 0) {  // player missed one
    numMissed++;
    querySelector("#num_missed").text = numMissed.toString();
    newWord();
  }
}

/// Randomly pick a new word and scramble it for display
void newWord() {
  secondsLeft = 60;
  wordList.shuffle();
  secretWord = wordList[0];
  List<String> tempList = secretWord.split("");  // divide word into letter strings
  tempList.shuffle();  // scramble the word for display
  querySelector("#scrambled_word").text = tempList.join();  // put it back together
  (querySelector("#guess") as InputElement).value = "";  // clear input text
}

void main() {
  querySelector("#guess").onKeyUp.listen(checkGuess);
  Timer t = new Timer.periodic(const Duration(seconds: 1), tick);
  newWord();  // get us started the first time the program is run
}