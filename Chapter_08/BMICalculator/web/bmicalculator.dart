// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:html';

bool imperial = true;
const int IMPERIAL_MULTIPLIER = 703;

void main() {
  querySelector("#unit_type1").onChange.listen(changeUnits);
  querySelector("#unit_type2").onChange.listen(changeUnits);
  querySelector("#submit").onClick.listen(calculate);
}

/// Change the units displayed by the inputs
/// and update [imperial]
void changeUnits(Event e) {
  // if imperial is checked
  if ((querySelector("#unit_type1") as RadioButtonInputElement).checked) {
    imperial = true;
    querySelector("#weight_units").text = "pounds";
    querySelector("#height_units").text = "inches";
  } else { // metric is checked
    imperial = false;
    querySelector("#weight_units").text = "kilograms";
    querySelector("#height_units").text = "meters";
  }
}

/// Check the height and weight inputs are valid
/// Calculate the bmi and display the results
void calculate(MouseEvent event) {
  double height, weight;
  // get the height and weight
  try {
    weight = double.parse((querySelector("#weight_input") as InputElement).value);
    height = double.parse((querySelector("#height_input") as InputElement).value);
  } on FormatException {  // uh oh, could not be turned into double
    window.alert("Only numbers are valid input.");  // popup alert
    return;
  }
  // do the actual calculations
  double bmi = weight / (height * height);
  if (imperial) {
    bmi = bmi * IMPERIAL_MULTIPLIER;
  }
  // update the display with a BMI rounded to 1 decimal digit
  querySelector("#result1").text = "Your BMI is " + bmi.toStringAsFixed(1);
  String comment;
  if (bmi < 18.5) {
    comment = "Underweight";
  } else if (bmi >= 18.5 && bmi < 25.0) {
    comment = "Normal";
  } else if (bmi >= 25.0 && bmi < 30.0) {
    comment = "Oveweight";
  } else {
    comment = "Obese";
  }
  querySelector("#result2").text = comment;
}
