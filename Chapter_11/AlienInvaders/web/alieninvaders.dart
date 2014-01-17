library alieninvaders;

import "dart:html";
import "dart:math";  // for Random and Rectangle
import "dart:async";  // for Timer

part "sprite.dart";
part "player.dart";
part "alien.dart";
part "bullet.dart";

CanvasElement myCanvas;
Player player;
List<Alien> aliens;
List<Bullet> alienBullets;
List<Bullet> playerBullets;
ImageElement background;
Timer t;

const int CANVAS_WIDTH = 500;
const int CANVAS_HEIGHT = 500;
const String BACKGROUND_FILE = "images/background.png";

/// Called by a Timer 60 times per second
/// Calls update() on all sprites, calls draw()
/// Creates alien bullets and checks for collisions
void update(Timer t) {
  // update everything
  player.update();
  for (Alien alien in aliens) {
    alien.update();
    // randomly fire a bullet
    Random rand = new Random();
    int randomNumber = rand.nextInt(2000);
    if (randomNumber == 100) {
      alienBullets.add(new Bullet(alien.x + Alien.WIDTH ~/ 2 - Bullet.WIDTH ~/ 2, alien.y + Alien.HEIGHT, true));
    }
  }

  List deleteBullets = new List();
  for (Bullet bullet in alienBullets) {
    bullet.update();
    if (bullet.y > CANVAS_HEIGHT) {  // is bullet off screen?
      deleteBullets.add(bullet);
      continue;
    }
    // check if bullets hit player
    if (bullet.checkCollision(player)) {
      t.cancel();  // stop the game, player is hit
      window.alert("Game Over!");
      deleteBullets.add(bullet);
    }
  }
  
  for (Bullet bullet in deleteBullets) {
    alienBullets.remove(bullet);
  }
  
  deleteBullets.clear();
  List deleteAliens = new List();
  for (Bullet bullet in playerBullets) {
    bullet.update();
    if (bullet.y < 0) {  // is bullet off screen
      deleteBullets.add(bullet);
      continue;
    }
    // check if bullet hits alien
    for (Alien alien in aliens) {
      if (bullet.checkCollision(alien)) {
        deleteBullets.add(bullet);
        deleteAliens.add(alien);
      }
    }
  }
  
  for (Bullet bullet in deleteBullets) {
    playerBullets.remove(bullet);
  }

  for (Alien alien in deleteAliens) {
    aliens.remove(alien);
    if (aliens.isEmpty) {
      t.cancel();  // stop the game, all aliens dead
      window.alert("You Win!");
    }
  }
  
  // draw everything
  draw();
}

/// Draw the background and all of the sprites
void draw() {
  CanvasRenderingContext2D c2D = myCanvas.context2D;
  // draw the background
  c2D.drawImage(background, 0, 0);
  // draw all the sprites
  player.draw(c2D);
  for (Alien alien in aliens) {
    alien.draw(c2D);
  }
  for (Bullet bullet in alienBullets) {
    bullet.draw(c2D);
  }
  for (Bullet bullet in playerBullets) {
    bullet.draw(c2D);
  }
}

/// Initialize all of the sprites
/// place the player and the aliens on the screen
void restart() {
  player = new Player(CANVAS_WIDTH ~/ 2, CANVAS_HEIGHT - Player.HEIGHT);
  aliens = new List();
  alienBullets = new List();
  playerBullets = new List();
  // probably don't want to hardcode this for Exercise 3; create the aliens
  const int NUM_ROWS = 3;
  const int NUM_COLUMNS = 5;
  for (int i = 0; i < NUM_ROWS; i++) {
    int y = i * (Alien.HEIGHT + 10);  // 10 is for spacing
    for (int j = 0; j < NUM_COLUMNS; j++) {
      int x = (CANVAS_WIDTH ~/ NUM_COLUMNS) * j + 10;  // ~/ is integer division
      aliens.add(new Alien(x,y));
    }
  }
  
  background = new ImageElement()
    ..src = BACKGROUND_FILE;
}

void main() {
  myCanvas = querySelector("#myCanvas");
  window.onKeyPress.listen((KeyboardEvent e) {  // manipulate player with key presses
    String lastPressed = new String.fromCharCodes([e.charCode]);
    switch (lastPressed) {
      case 'z':  // move player left
        if (player.x > 0) {
          player.move(-5, 0);
        }
        break;
      case 'x':  // move player right
        if (player.x < CANVAS_WIDTH - Player.WIDTH) {
          player.move(5, 0);
        }
        break;
      case ' ':  // player fires
        playerBullets.add(new Bullet(player.x + Player.WIDTH ~/ 2 - Bullet.WIDTH ~/ 2, player.y - Bullet.HEIGHT, false));
        break;
    }
  });
  restart();
  // this Timer will call update() approximately 60 times a second
  t = new Timer.periodic(const Duration(milliseconds:17), update);
}