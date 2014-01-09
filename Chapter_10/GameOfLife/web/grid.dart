// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

part of life;

class Grid {
  static const int NUM_CELLS_WIDE = 25;
  static const int NUM_CELLS_TALL = 25;
  CanvasElement lifeCanvas;
  Map<Point, Cell> cells = new Map();
  
  Grid(this.lifeCanvas) {
    // initialize  all the cells
    for (int x = 0; x < NUM_CELLS_WIDE; x++) {
      for (int y = 0; y < NUM_CELLS_TALL; y++) {
        Point location = new Point(x, y);
        cells[location] = new Cell(location);
      }
    }
  }
  
  /// Get a cell at a given location by looking it up
  /// in the cells Map. If its coordinates are off the end of the
  /// grid, we wrap around to the other side of the grid.
  Cell getCell(int x, int y) {
    // wrap around in x direction
    if (x < 0) {
      x = NUM_CELLS_WIDE - 1;
    } else if (x >= NUM_CELLS_WIDE) {
      x = 0;
    }
    // wrap around in y direction
    if (y < 0) {
      y = NUM_CELLS_TALL - 1;
    } else if (y >= NUM_CELLS_TALL) {
      y = 0;
    }
    
    return cells[new Point(x, y)];
  }
  
  /// Switch the status of the cell at the location x, y
  void flip(int x, int y) {
    Cell cell = cells[new Point(x ~/ Cell.WIDTH, y ~/ Cell.HEIGHT)];
    cell.alive = !cell.alive;
    cell.draw(lifeCanvas.context2D);
  }
  
  /// Check the eight cells around [cell] to see if they're alive
  /// count how many of them are
  int aliveNeighbors(Cell cell) {
    int x = cell.location.x, y = cell.location.y;
    int newX, newY;
    int numAlive = 0;
    // top left cell
    newX = x - 1;
    newY = y - 1;
    if (getCell(newX, newY).alive) {
      numAlive++;
    }
    // top cell
    newX = x;
    newY = y - 1;
    if (getCell(newX, newY).alive) {
      numAlive++;
    }
    // top right cell
    newX = x + 1;
    newY = y - 1;
    if (getCell(newX, newY).alive) {
      numAlive++;
    }
    // left cell
    newX = x - 1;
    newY = y;
    if (getCell(newX, newY).alive) {
      numAlive++;
    }
    // right cell
    newX = x + 1;
    newY = y;
    if (getCell(newX, newY).alive) {
      numAlive++;
    }
    // bottom left cell
    newX = x - 1;
    newY = y + 1;
    if (getCell(newX, newY).alive) {
      numAlive++;
    }
    // bottom cell
    newX = x;
    newY = y + 1;
    if (getCell(newX, newY).alive) {
      numAlive++;
    }
    // bottom right cell
    newX = x + 1;
    newY = y + 1;
    if (getCell(newX, newY).alive) {
      numAlive++;
    }
    return numAlive;
  }
  
  /// draw the whole grid once - useful before any play takes place
  void drawOnce() {
    CanvasRenderingContext2D c2d = lifeCanvas.context2D;
    for (Cell cell in cells.values) {
      cell.draw(c2d);
    }
  }
  
  /// figure out what the next generation should look like
  /// then flip everyone over into the next generation and redraw
  void update(Timer t) {
    // loop through all cells and calculate who's alive next generation
    for (Cell cell in cells.values) {
      int livingNeighbors = aliveNeighbors(cell);
      cell.aliveNextGeneration = false;  // our default stance
      if (cell.alive) {
        if (livingNeighbors == 3 || livingNeighbors == 2) {
          cell.aliveNextGeneration = true;
        }
      } else {
        if (livingNeighbors == 3) {
          cell.aliveNextGeneration = true;
        }
      }
    }
    
    // flip the values for the next generation into the current values
    // effectively moving into the next generation and draw everyone
    CanvasRenderingContext2D c2d = lifeCanvas.context2D;
    for (Cell cell in cells.values) {
      cell.alive = cell.aliveNextGeneration;
      cell.draw(c2d);
    }
  }
}