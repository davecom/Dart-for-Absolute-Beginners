// Copyright 2014 David Kopec
// Created for Dart for Absolute Beginners, an Apress title
// This source code is released under the terms outlined in license.txt in the
// source code respository's root directory.

import "dart:io";

/// returns a Map that maps letters to other letters
/// 13 places away in the English alphabet
Map getROT13Map() {
  const List<String> ALPHABET = const ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
  const int CHANGE = 13;  // how many places to move letters
  Map<String, String> code = {};
  
  for (int i = 0; i < ALPHABET.length; i++) {
    if (i < CHANGE){  // move first 13 letters 13 places forward A=N
      code[ALPHABET[i]] = ALPHABET[i + CHANGE];
      code[ALPHABET[i].toUpperCase()] = ALPHABET[i + CHANGE].toUpperCase();
    } else {  // last 13 letters go 13 places back N=A
      code[ALPHABET[i]] = ALPHABET[i - CHANGE];
      code[ALPHABET[i].toUpperCase()] = ALPHABET[i - CHANGE].toUpperCase();
    }
  }
  return code;
}

void main() {
  Map<String, String> secretCode = getROT13Map();
  print("Enter the text you want to encrypt:");
  String original = stdin.readLineSync();  // user input
  String changed = "";
  for (String character in original.split('')) {  // get list of characters
    if (secretCode.containsKey(character)) {  // containsKey() checks if key exists
      changed += secretCode[character];
    } else {
      changed += character;
    }
  }
  print(changed);
}
