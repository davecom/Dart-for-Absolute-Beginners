// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import "dart:isolate";
import "dart:async";
import "dart:math";

const int NUM_PHILOSOPHERS = 5;

/// Represents one of our philosopher Isolates
void philosopher(SendPort backToMain) {
  Timer askTimer;
  ReceivePort incoming = new ReceivePort();
  
  incoming.listen((var data) {  // coming from main
    if (data == "Eat!") {
      askTimer.cancel();  // stop asking to eat
      Random r = new Random();
      int secondsToEat = r.nextInt(10);  // takes 0-9 seconds to eat
      Timer t = new Timer(new Duration(seconds: secondsToEat), () {
        backToMain.send("Finished!");  // announce done
        incoming.close();
      });
    }
  });

  backToMain.send(incoming.sendPort); // provide a means of communication here
  askTimer = new Timer.periodic(new Duration(seconds: 1), (Timer t){
    backToMain.send("I want to eat!"); // continuously request to eat
  });
}

void main() {
  List<ReceivePort> philosopherReceives = new List(NUM_PHILOSOPHERS);
  List<SendPort> philosopherSends = new List(NUM_PHILOSOPHERS);
  List<bool> forksInUse = new List(NUM_PHILOSOPHERS);
  
  for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
    forksInUse[i] = false;
    philosopherReceives[i] = new ReceivePort();
    
    philosopherReceives[i].listen((var data) {
      if (data is SendPort) {
        philosopherSends[i] = data;
      } else if (data == "I want to eat!") {
        print("Philosopher $i wants to eat.");
        if (i == (NUM_PHILOSOPHERS - 1)) {
          if (forksInUse[0] == false && forksInUse[i] == false) {
            print("Telling philosopher $i to eat.");
            forksInUse[0] = true;
            forksInUse[i] = true;
            philosopherSends[i].send("Eat!");
          } 
        } else {
          if (forksInUse[i] == false && forksInUse[i + 1] == false) {
            print("Telling philosopher $i to eat.");
            forksInUse[i] = true;
            forksInUse[i + 1] = true;
            philosopherSends[i].send("Eat!");
          }
        }
      } else if (data == "Finished!") {
        forksInUse[i] = false;
        if (i == (NUM_PHILOSOPHERS - 1)) {
          forksInUse[0] = false;
        } else {
          forksInUse[i + 1] = false;
        }
        print("Philosopher $i finished eating.");
        philosopherReceives[i].close();
      }
    });
    
    Isolate.spawn(philosopher, philosopherReceives[i].sendPort);
  }
}
