void main() {
  // Given grades
  const List<int> grades = [85, 92, 78, 65, 88, 72];

  // Calculating average grade
  int totalGrade = 0;
  for (int grade in grades) {
    totalGrade += grade;
  }
  final double averageGrade = totalGrade / grades.length;
  final int roundedAverageGrade = averageGrade.round();

  // Printing result
  print('Student\'s average grade: ${averageGrade.toStringAsFixed(2)}');
  print('Rounded average: $roundedAverageGrade');

  if (roundedAverageGrade >= 70) {
    print('Passed');
  } else {
    print('Failed');
  }
}
