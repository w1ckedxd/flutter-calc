import 'package:calculator/src/components/button.dart';
import 'package:flutter/material.dart';

enum CalcButtonType { operator, digit }

class CalcButton extends StatelessWidget {
  const CalcButton({
    super.key,
    required this.child,
    this.size = 90.0,
    required this.onCalcButtonPressed,
    required this.value,
    this.type = CalcButtonType.digit,
  });

  final CalcButtonType type;
  final String child;
  final double size;
  final void Function(String value, CalcButtonType type) onCalcButtonPressed;
  final String value;

  void handleCalcButtonPressed() {
    onCalcButtonPressed(value, type);
  }

  @override
  Widget build(BuildContext context) {
    Color calcBackgroundColor = const Color(0xFFA4D5FD);
    Color calcOverlayColor = const Color(0xFF91CBFB);
    Color calcTextColor = const Color(0xFF22649A);

    if (type == CalcButtonType.operator) {
      calcBackgroundColor = const Color(0xFFF3A3BD);
      calcOverlayColor = const Color(0xFFF090AE);
      calcTextColor = const Color(0xFF6B1D36);
    }

    return CustomButton(
      width: size,
      height: size,
      borderRadius: size / 2,
      backgroundColor: calcBackgroundColor,
      overlayColor: calcOverlayColor,
      onButtonPressed: handleCalcButtonPressed,
      child: Text(
        child,
        style: TextStyle(
          fontSize: size / 2,
          color: calcTextColor,
        ),
      ),
    );
  }
}
