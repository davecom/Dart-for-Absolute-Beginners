// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:html';
import 'dart:async';  // for Timer

// A lot of constants makes for maintainable code as opposed
// to using magic numbers (or magic Strings for that matter)
const int NUM_CARDS = 16;
const int NUM_OF_EACH = 4;
const String CARD_BACK = "images/card_back.png";
List<String> CARD_FILE_NAMES = ["images/dog.png", "images/cat.png", 
                                "images/giraffe.png", "images/turtle.png"];

int strikes, cardsLeft;
List<String> cards;  // the actual deck
ImageElement lastClicked; // last card clicked if not two clicked

/// Resets the game board for a new game
void reset() {
  strikes = 0;
  cardsLeft = NUM_CARDS;
  querySelector("#num_strikes").text =  strikes.toString();
  querySelector("#num_left").text =  cardsLeft.toString();
  // find all <img> Elements in the DOM and change their src
  // attribute to be that of the facedown card
  for (ImageElement img in querySelectorAll("img")) {
    img.src = CARD_BACK;
  }
  //create the randomly ordered deck of cards
  cards = new List();
  for (String cardFileName in CARD_FILE_NAMES) {
    for (int i = 0; i < NUM_OF_EACH; i++) {
      cards.add(cardFileName);
    }
  }
  cards.shuffle();
}

/// Main game logic, checks if two cards have been matched
/// or not; also flips cards when clicked
void cardClicked(MouseEvent event) {
  ImageElement clickedCard = event.target; // which card was clicked
  // if the card's already turned over, ignore
  if (!clickedCard.src.endsWith(CARD_BACK)) {
    return;
  }
  // otherwise flip it over
  int clickedNumber = int.parse(clickedCard.alt); // thing we stored
  clickedCard.src = cards[clickedNumber];
  
  if (lastClicked == null) {
    lastClicked = clickedCard;
  } else {
    
    if (clickedCard.src == lastClicked.src) { // we have a match!
      cardsLeft -= 2;
      querySelector("#num_left").text =  cardsLeft.toString();
      
    } else { // we have a strike!
      strikes++;
      querySelector("#num_strikes").text =  strikes.toString();
      
      // flip them back after 2 seconds
      ImageElement tempClicked = lastClicked;
      Timer t = new Timer(const Duration(seconds: 2), () {
        clickedCard.src = CARD_BACK;
        tempClicked.src = CARD_BACK;
      }); 
    }
    lastClicked = null;
  }
}

void newGame(MouseEvent event) => reset();

void main() {
  // add the img elements, you didn't think we were going to type
  // <img...> 16 times, did you? Computers are better at repetitive tasks.
  for (int i = 0; i < NUM_CARDS; i++) {
    ImageElement ie = new ImageElement(height: 100, width: 100);
    ie.onClick.listen(cardClicked);
    ie.alt = i.toString(); // a way of tagging the cards
    querySelector("#card_box").append(ie);
  }
  querySelector("#new_game_button").onClick.listen(newGame);
  reset();
}
