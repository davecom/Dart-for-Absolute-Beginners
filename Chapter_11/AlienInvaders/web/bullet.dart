part of alieninvaders;

class Bullet extends Sprite {
  static const int WIDTH = 15, HEIGHT = 15;
  static const String IMAGE_NAME = "images/bullet.png";
  bool down;
  
  Bullet(int x, int y, this.down) : super(WIDTH, HEIGHT, x, y, IMAGE_NAME);
  
  /// Move down or up 1 every frame
  void update() {
    if (down) {
      move(0, 1);
    } else {
      move(0, -1);
    }
  }
  
  /// is the bullet within the space of [s]?
  bool checkCollision(Sprite s) {
    if (boundingBox.intersection(s.boundingBox) != null) {
      return true;
    }
    return false;
  }
}