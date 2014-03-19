String addOn(String original, String additional, int times) {
  if (times <= 0) {  // exit condition to end "recursive loop"
    return original;
  }
  return addOn(original + additional, additional, times - 1);  // recursive call
}

void main() {
  print(addOn("Hello", "!", 2));
}