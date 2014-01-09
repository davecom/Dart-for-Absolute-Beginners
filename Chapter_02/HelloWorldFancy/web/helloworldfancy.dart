// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import 'dart:html';

void main() {
  querySelector("#button").onClick.listen(sayHello);
}

void sayHello(MouseEvent event) {
  querySelector("#name").text = (querySelector("#name_box") as InputElement).value;
  (querySelector("#name_box") as InputElement).value = "";
}
