class CalcUtils {
  static caclulateResult(double num1, double num2, String operator) {
    switch (operator) {
      case '+':
        return CalcUtils.add(num1, num2);
      case '-':
        return CalcUtils.subtraction(num1, num2);
      case '*':
        return CalcUtils.multiplication(num1, num2);
      case '/':
        return CalcUtils.division(num1, num2);
      default:
        print('default');
        break;
    }
  }

  static double add(double num1, double num2) {
    return num1 + num2;
  }

  static double subtraction(double num1, double num2) {
    return num1 - num2;
  }

  static double multiplication(double num1, double num2) {
    return num1 * num2;
  }

  static double division(double num1, double num2) {
    return num1 / num2;
  }
}
