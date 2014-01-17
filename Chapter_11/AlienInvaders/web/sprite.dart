part of alieninvaders;

abstract class Sprite {
  int width, height, x, y;
  ImageElement myImage;
  Rectangle boundingBox;  // for collisions
  
  Sprite(this.width, this.height, this.x, this.y, String imageName) {
    myImage = new ImageElement()
      ..src = imageName;
    boundingBox = new Rectangle(x, y, width, height);
  }
  
  /// just draws [myImage] in the canvas
  void draw(CanvasRenderingContext2D c2D) {
    c2D.drawImageScaled(myImage, x, y, width, height);
  }
  
  /// move [dx] in the x direction, [dy] in the y direction
  void move(int dx, int dy) {
    x += dx;
    y += dy;
    boundingBox = new Rectangle(x, y, width, height);
  }
  
  /// left to subclasses
  void update();
}