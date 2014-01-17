part of alieninvaders;

class Player extends Sprite {
  static const int WIDTH = 73, HEIGHT = 80;
  static const String IMAGE_NAME = "images/ship.png";
  
  Player(int x, int y) : super(WIDTH, HEIGHT, x, y, IMAGE_NAME);
  
  void update() {  // doesn't do anything, player updates from keyboard events
    return;
  }
}