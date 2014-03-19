part of wordsearch;

class WordSearchConstraint extends ListConstraint {
  WordSearchConstraint(List words): super(words);

  /// This constraint is satisfied when no words overlap in the grid
  @override
  bool isSatisfied(Map assignment) {
    List allPointsUsed = [];
    for (List<Point> wordPlaces in assignment.values) {
      allPointsUsed.addAll(wordPlaces);
    }
    Set allPointsUsedSet = allPointsUsed.toSet();
    if (allPointsUsedSet.length < allPointsUsed.length) {  // duplicates check
      return false;  // must be an overlap of words
    } else {
      return true;
    }
  }
}
