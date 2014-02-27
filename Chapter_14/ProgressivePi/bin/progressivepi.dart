// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import "dart:isolate";

void calcPi(SendPort sp) {
  const int ITERATIONS = 1000000000;  // the higher the more accurate
  double series = 1.0;
  double denominator = 3.0;
  double negate = -1.0;

  for (int i = 0; i < ITERATIONS; i++) {
    series += (negate * (1 / denominator));
    denominator += 2.0;
    negate *= -1.0;
    if (i / ITERATIONS == 0.25 || i / ITERATIONS == 0.50 || i / ITERATIONS == 0.75) {
      sp.send("${(i / ITERATIONS * 100)}% Complete");
    }
  }

  double pi = 4 * series;
  sp.send(pi);  // send the result back
}

void main() {
  ReceivePort rp = new ReceivePort();
  rp.listen((data) {  // data is what we receive from sp.send()
    if (data is String) {  // it's a progress report, not the result
      print(data);
    } else {
      print("Pi is $data");
      rp.close();  // we're done, close up shop
    }
  });
  Isolate.spawn(calcPi, rp.sendPort);  // start the Isolate
}
