// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:html';
import 'dart:async';  // for Timer
import 'dart:math';  // for Random

const int PIG_WIDTH = 100;
const int PIG_HEIGHT = 50;
const String PIG_RIGHT = "images/pig_right.png";
const String PIG_LEFT = "images/pig_left.png";

int pigX, pigY, score = 0, speed;
CanvasElement myCanvas;
ImageElement pigImage;

/// Called by a Timer 60 times per second
void update(Timer t) {
  pigX += speed;  //update pig's location
  // get a new pig when the last one has gone off screen
  if (pigX < (-PIG_WIDTH) || pigX > myCanvas.width){
    newRandomPig();
  }
  draw();
}

/// Draw a background, the pig, and the score
void draw() {
  CanvasRenderingContext2D myCanvasContext = myCanvas.context2D;
  //draw the background
  myCanvasContext.setFillColorRgb(0, 0, 255);  // Blue
  myCanvasContext.fillRect(0, 0, 500, 500);  // 0x, 0y, 500 width, 500 height
  //draw the score in black at the top right of the screen
  String scoreText = "Score: $score";
  myCanvasContext.setFillColorRgb(0, 0, 0);  // Black
  myCanvasContext.fillText(scoreText, myCanvas.width-100, 30); // string, x, y
  //draw the pig
  myCanvasContext.drawImageScaled(pigImage, pigX, pigY, PIG_WIDTH, PIG_HEIGHT);
}

/// Sets up a new pig at a random location
void newRandomPig() {
  // if it's 1 it will go right, otherwise left
  Random rand = new Random();
  speed = rand.nextInt(10) + 5;  // random speed 5 to 14 pixels/frame
  pigY = rand.nextInt(myCanvas.height - PIG_HEIGHT);  // random y
  int leftOrRight = rand.nextInt(2);
  if (leftOrRight == 1) {  // going from left to right
    pigX = 0;
    pigImage.src = PIG_RIGHT;
  } else {   //going from right to left
    pigX = myCanvas.width - PIG_WIDTH;
    pigImage.src = PIG_LEFT;
    speed = -speed;  // move left not right
  }
}

/// When the canvas is clicked, we need to check if the user hit a pig
void clickHappened(MouseEvent me) {
  //check if click was within the pig's space
  int clickX = me.offset.x;
  int clickY = me.offset.y;
  if (clickX > pigX && clickX < pigX + PIG_WIDTH 
      && clickY > pigY && clickY < pigY + PIG_HEIGHT) {  // we have a hit
    score++;
    newRandomPig();
  }
}

void main() {
  myCanvas = querySelector("#myCanvas");
  myCanvas.onClick.listen(clickHappened);
  pigImage = new ImageElement();
  newRandomPig();
  // This Timer will call update() approximately 60 times a second
  Timer t = new Timer.periodic(const Duration(milliseconds:17), update);
}