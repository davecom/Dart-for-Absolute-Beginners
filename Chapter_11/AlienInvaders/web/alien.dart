part of alieninvaders;

class Alien extends Sprite {
  static const int WIDTH = 80, HEIGHT = 40;
  static const String IMAGE_NAME = "images/ufo.png";
  int frameCount = 0;
  
  Alien(int x, int y) : super(WIDTH, HEIGHT, x, y, IMAGE_NAME);
  
  /// Move every second or so (assuming 60 frames per second)
  void update() {
    frameCount++;
    if (frameCount % 60 == 0) {
      move(0, 1);  // move one down
    }
  }
}
