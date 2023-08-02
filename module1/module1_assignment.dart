void main() {
  const int a = 19;
  const int b = 12;

  print('a = $a, b = $b');

  // Addition
  int sum = a + b;
  print('Addition: $a + $b = $sum');

  // Subtraction
  int difference = a - b;
  print('Subtraction: $a - $b = $difference');

  // Multiplication
  int product = a * b;
  print('Multiplication: $a * $b = $product');

  // Division
  double quotient = a / b; // Use double to get decimal value for division
  print('Division: $a / $b = $quotient');

  // Modulus
  int remainder = a % b;
  print('Modulus: $a % $b = $remainder');
}
