// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import "dart:math";

/// Returns a List with 23 randomly
/// generated birthdays in it
List<DateTime> generateBirthdays() {
  List<DateTime> birthdays = new List<DateTime>();
  Random r = new Random();
  const int YEAR = 1987;
  const int NUM_MONTHS = 12;
  const int NUM_DAYS = 28;  // For simplicity we limit to 28
  const int BIRTHDAYS_TO_GENERATE = 23;
  
  for (int i = 0; i < BIRTHDAYS_TO_GENERATE; i++) {
    int randMonth = r.nextInt(NUM_MONTHS) + 1;  // random number 1-12
    int randDay = r.nextInt(NUM_DAYS) + 1;  // random number 1-28
    birthdays.add(new DateTime(YEAR, randMonth, randDay));
  }
  return birthdays;
}

/// Returns true if [l] has duplicate elements
/// Otherwise returns false
bool containsDuplicates(List l) {
  for (int i = 0; i < l.length; i++) {
    if (l.skip(i + 1).contains(l[i])) {  // check if rest of l contains i
      return true;
    }
  }
  return false;
}

void main() {
  const int ITERATIONS = 10000;
  List<DateTime> birthdays;
  int matches = 0;
  
  for (int i = 0; i < ITERATIONS; i++) {
    birthdays = generateBirthdays();  // new list of birthdays each iteration
    if (containsDuplicates(birthdays)) {
      matches++;
    }
  }

  print("There were at least two people with the same birthday ${(matches / ITERATIONS) * 100}% of the time.");
}
