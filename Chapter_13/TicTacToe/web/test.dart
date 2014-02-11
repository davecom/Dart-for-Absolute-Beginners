// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import "package:unittest/unittest.dart";
import "board.dart";

void main() {
  group("makeMove() Tests", (){  // no duplicate moves allowed!
    List moves = [[5, true], [5, false], [4, true], [3, true], [4, false]];
    Board board = new Board();
    int moveNum = 1;
    for (List move in moves) {
        test("Move " + moveNum.toString(), (){
          expect(board.makeMove(move[0]), equals(move[1]));
        });
        moveNum++;
    }
  });
  
  // every time we make 9 random moves, the game should end in a win or draw
  group("Random Moves Tests", (){
    const int MAX_MOVES = 9;
    for (int j = 0; j < 10; j++) {  // play 10 random games
      Board board = new Board();
      test("Random Game " + j.toString(), (){
        bool gameWon = false;
        for (int i = 0; i < MAX_MOVES; i++) {
          List legalMoves = board.legalMoves;
          legalMoves.shuffle();
          board.makeMove(legalMoves[0]);
          if (board.winner != null) {
            gameWon = true;
            break;
          }
        }
        expect(gameWon || board.isDraw, isTrue);
      });
    }
  });
  
  group("winner Tests", (){  // winner should be the end of the List
    List games = [[[0, 6, 1, 3, 2], "X"], [[3, 0, 7, 4, 2, 8], "O"]];
    int gameNum = 1;
    for (List game in games) {
      Board board = new Board();
      for (int move in game[0]) {
        board.makeMove(move);
      }
      test("Game " + gameNum.toString(), (){
        expect(board.winner, equals(game[1]));
      });
      gameNum++;
    }
  });
}