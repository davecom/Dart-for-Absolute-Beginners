import "dart:math";
import "dart:io";

abstract class Shape {
  double get perimeter;
  double get area;
  String get description;
}

class Circle extends Shape {
  double radius;
  Circle(this.radius);
  
  double get perimeter => radius * 2 * PI;
  double get area => PI * (radius * radius);
  String get description => "I am a circle with radius $radius";
}

class Rectangle extends Shape {
  double length;
  double width;
  Rectangle(this.length, this.width);
  
  double get perimeter => length * 2 + width * 2;
  double get area => length * width;
  String get description => "I am a rectangle with length $length and width $width.";
}

class Square extends Rectangle {
  Square(double side) : super(side, side);
  String get description => "I am a square with sides of length $length.";
}

void main() {
  Shape randomShape;
  Random rand = new Random();
  int choice = rand.nextInt(3);
  
  switch(choice) {
    case 0:
      randomShape = new Circle(rand.nextInt(10) + 1.0);  // adding 1.0 converts to double
      break;
    case 1:
      randomShape = new Rectangle(rand.nextInt(10) + 1.0, rand.nextInt(10) + 1.0);
      break;
    case 2:
      randomShape = new Square(rand.nextInt(10) + 1.0);
      break;
  }
  
  String inTemp;
  double userAnswer;
  print(randomShape.description);
  
  print("What is the area of the shape?");
  inTemp = stdin.readLineSync();
  try {
    userAnswer = double.parse(inTemp);
  } on FormatException {  // uh oh, could not be turned into double
    print("Could not interpret input.");
    return;
  }
  if (userAnswer.roundToDouble() == randomShape.area.roundToDouble()) {
    print("Good job!");
  } else {
    print("Wrong, it's ${randomShape.area}!");
  }
  
  print("What is the perimeter of the shape?");
  inTemp = stdin.readLineSync();
  try {
    userAnswer = double.parse(inTemp);
  } on FormatException {  // uh oh, could not be turned into double
    print("Could not interpret input.");
    return;
  }
  if (userAnswer.roundToDouble() == randomShape.perimeter.roundToDouble()) {
    print("Good job!");
  } else {
    print("Wrong, it's ${randomShape.perimeter}!");
  }
}
