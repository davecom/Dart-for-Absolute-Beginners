// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import "dart:io";

/// Calculate the score of the [cards] List
int calculateScore(List cards) {
  int score = 0;
  bool hasAce = false;  // only one ace in Simple Blackjack
  
  for (var card in cards) {  // use var because card can be int or String
    if (card is int) {  // is operator, check type of card
      score += card;
    } else if (card == "A") {
      hasAce = true;
    } else {  // must be king, queen, or jack
      score += 10;
    }
  }
  
  if (hasAce) {
    if ((score + 11) > 21) {  // don't let ace cause bust
      score += 1;
    } else {
      score += 11;
    }
  }
  
  return score;
}

/// Print everyone's scores and decks
void printStatus(playerCards, dealerCards) {
  print("");  // blank line
  print("Player's Total is ${calculateScore(playerCards)}:");
  print(playerCards);  // automatically prints contents of List
  print("Dealer's Total is ${calculateScore(dealerCards)}");
  print(dealerCards);
  print("");  // blank line
}

void main() {
    List deck = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"];
    List playerCards = [], dealerCards = [];
    
    deck.shuffle();
    
    print("Dealer draws first card.");
    dealerCards.add(deck.removeLast());  // move 1 card from deck to dealerCards
    print("Player receives two cards.");
    playerCards.add(deck.removeLast());  // move 1 card from deck to playerCards
    playerCards.add(deck.removeLast());
    printStatus(playerCards, dealerCards);
    
    while (true) {  // player decision loop
      print("Do you want to (H)it, (S)tay, or (Q)uit?");
      String selection = stdin.readLineSync().toUpperCase();  // get uppercase input
    
      if (selection == "H") {  // hit
        playerCards.add(deck.removeLast());
        printStatus(playerCards, dealerCards);
        
        if (calculateScore(playerCards) > 21) {
          print("You busted!  You lose!");
          exit(0);  // quits the program
        }
      } else if (selection == "S") {  // stay
        break;  // stop offering to hit, leave this loop
      } else if (selection == "Q") {  // quit
        exit(0);  // quits the program
      }
    }
    
    print("Dealer draws rest of cards.");
    while (calculateScore(dealerCards) < 17) {  // keep drawing cards till 17
      dealerCards.add(deck.removeLast());
    }
    printStatus(playerCards, dealerCards);
    
    if (calculateScore(dealerCards) > 21) {  // dealer bust
      print("Dealer busts!  You win!");
    } else if (calculateScore(dealerCards) > calculateScore(playerCards)) {
      print("Dealer wins!");
    } else if (calculateScore(dealerCards) < calculateScore(playerCards)) {
      print("You win!");
    } else {  // must be a tie by default
      print("It's a tie!");
    }
}
