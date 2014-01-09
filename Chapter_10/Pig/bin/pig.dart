// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

library pig;

import "dart:math";  // for Random
import "dart:io";  // for stdin

part "dice.dart";
part "player.dart";

List<Player> players = [];
Dice d = new Dice(6,1);  // 6 sides, 1 die;

/// initialize [players]
void createPlayers() {
  int numPlayers;
  
  do {
    print("How many players will be playing?");
    String inTemp = stdin.readLineSync();
    try {
      numPlayers = int.parse(inTemp);
    } on FormatException {  // uh oh, could not be turned into integer
      print("Not a valid selection");
      exit(0);  // exit
    }
  } while (numPlayers < 1);  // can't have <1 players
  
  // create the Player objects responsible for tracking
  for (int i = 1; i <= numPlayers; i++) {
    print("What is Player $i's name?");
    String name = stdin.readLineSync();
    Player player = new Player(name);
    players.add(player);
  }
}

void main() {
  createPlayers();
  
  // main game loop
  while (true) {
    for (Player player in players) {
      int turnTotal = 0;
      print("");  // blank line for spacing
      print("It's ${player.name}'s turn with a score of ${player.score}.");
      
      String move;
      do {
         move = player.getMove();
        
        if (move == "Roll") {
          d.roll();
          print("${player.name} rolled a ${d.total}.");
          
          if (d.total == 1) {
            print("${player.name} loses a turn.");
            break;
          } else {
            turnTotal += d.total;
          }
        } else { // Player can only select Roll or Stay, so this is Stay
          
          player.score += turnTotal;
          print("${player.name}'s turn ends with a score of ${player.score}.");
          
          if (player.score >= 100) {  // check for win
            print("${player.name} won!");
            exit(0);
          }
        }
      } while (move == "Roll");
    }
  }
}
