// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:html';
import 'dart:math';

int wrongGuesses;
const int GUESS_LIMIT = 5;
const String WORD_LIST_FILE = "word_lists/hanglist.txt";
const String CAPITAL_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const List<String> HANG_IMAGES = const ["images/hang0.gif", "images/hang1.gif",
                                        "images/hang2.gif", "images/hang3.gif",
                                        "images/hang4.gif", "images/hang5.gif",
                                        "images/hang6.gif"];
String lettersLeft, secretWord;
bool gameOver;

void main() {
  // listen for keyboard input, also listen for clicks to the new game button
  window.onKeyPress.listen((KeyboardEvent e) {
    String lastPressed = new String.fromCharCodes([e.charCode]);
    lastPressed = lastPressed.toUpperCase();
    playLetter(lastPressed);
  });
  querySelector("#new_game_button").onClick.listen((MouseEvent me) => restart());
  restart();
}

/// The user has tried to play [letter] - see if it's in the secret word
/// if it is uncover it. If it's not, process a miss.
void playLetter(String letter) {
  if (lettersLeft.contains(letter) && !gameOver) {
    lettersLeft = lettersLeft.replaceFirst(new RegExp(letter), '');
    querySelector("#letter_list").text = lettersLeft;
    
    //put the letter into the secret word
    if (secretWord.contains(letter)) {
      String oldDisplay = querySelector("#secret").text;  // what the user sees
      String newDisplay = "";  // what we will soon show the user
      for (int i = 0; i < secretWord.length; i++) {
        if (secretWord[i] == letter) {  // put the new
          newDisplay = newDisplay + letter;
        }
        else {  // put the old back in
          newDisplay = newDisplay + oldDisplay[i];
        }
      }
      querySelector("#secret").text = newDisplay;
      
      if (newDisplay == secretWord) {  // if we won
        gameOver = true;
        querySelector("#letter_list").text = "YOU WIN";
      }
    }
    else {  // secretWord does not contain letter
      wrongGuesses++;
      (querySelector("#hang_image") as ImageElement).src = HANG_IMAGES[wrongGuesses];
      if (wrongGuesses > GUESS_LIMIT) {
        gameOver = true;
        querySelector("#letter_list").text = "GAME OVER";
        querySelector("#secret").text = secretWord;
      }
    }
    //do an else and move the hangman forward and check for loss or win
  }
  
}

/// Grab a random word from the hanglist.txt file for [secretWord]
void chooseSecretWord() {
  String url = WORD_LIST_FILE;
  HttpRequest request = new HttpRequest();
  request.open("GET", url, async: false);
  request.send();
  String wordList = request.responseText;
  List<String> words = wordList.split('\n');  // convert text file into List of words
  
  // randomly choose a word from the List
  Random rnd = new Random();
  secretWord = words[rnd.nextInt(words.length)];
  secretWord = secretWord.toUpperCase();
  
  // hide what we display to the user - all underscores for letters
  querySelector("#secret").text = secretWord.replaceAll(new RegExp(r'[a-zA-Z]'), "_");
}

/// Put everything in the starting position
void clearBoard() {
  wrongGuesses = 0;
  (querySelector("#hang_image") as ImageElement).src = HANG_IMAGES[wrongGuesses];
  lettersLeft = CAPITAL_ALPHABET;
  querySelector("#letter_list").text = lettersLeft;
}

/// Reset everything for a new game
void restart() {
  gameOver = false;
  chooseSecretWord();
  clearBoard();
}