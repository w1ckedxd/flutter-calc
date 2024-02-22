import 'package:calculator/src/components/button.dart';
import 'package:flutter/material.dart';

enum CalcButtonType { operator, digit, processing }

enum CalcButton {
  dot('.', type: CalcButtonType.operator),
  lastDelete('<', type: CalcButtonType.processing),
  procent('%', type: CalcButtonType.operator),
  parentheses ('()', type: CalcButtonType.operator),
  plus('+', priority: 1, type: CalcButtonType.operator),
  minus('-', priority: 1, type: CalcButtonType.operator),
  mult('*',
      priority: 2,
      type: CalcButtonType.operator,
      inLineWith: [CalcButton.minus]),
  div('/',
      priority: 2,
      type: CalcButtonType.operator,
      inLineWith: [CalcButton.minus]),
  ac('AC', type: CalcButtonType.processing),
  equal('=', type: CalcButtonType.processing),
  zero('0', type: CalcButtonType.digit),
  one('1', type: CalcButtonType.digit),
  two('2', type: CalcButtonType.digit),
  three('3', type: CalcButtonType.digit),
  four('4', type: CalcButtonType.digit),
  five('5', type: CalcButtonType.digit),
  six('6', type: CalcButtonType.digit),
  seven('7', type: CalcButtonType.digit),
  eight('8', type: CalcButtonType.digit),
  nine('9', type: CalcButtonType.digit);

  final String value;
  final int priority;
  final CalcButtonType type;
  final List<CalcButton>? inLineWith;

  const CalcButton(
    this.value, {
    this.priority = -1,
    required this.type,
    this.inLineWith,
  });
}

class CalcButtonWidget extends StatelessWidget {
  const CalcButtonWidget({
    super.key,
    required this.child,
    this.size = 90.0,
    required this.onCalcButtonPressed,
    required this.props,
  });

  final String child;
  final double size;
  final CalcButton props;
  final void Function(CalcButton buttonProps) onCalcButtonPressed;

  void handleCalcButtonPressed() {
    onCalcButtonPressed(props);
  }

  @override
  Widget build(BuildContext context) {
    Color calcBackgroundColor = const Color(0xFFA4D5FD);
    Color calcOverlayColor = const Color(0xFF91CBFB);
    Color calcTextColor = const Color(0xFF22649A);

    if (props.type == CalcButtonType.operator) {
      calcBackgroundColor = const Color(0xFFF3A3BD);
      calcOverlayColor = const Color(0xFFF090AE);
      calcTextColor = const Color(0xFF6B1D36);
    }
    if (props.type == CalcButtonType.processing) {
      calcBackgroundColor = const Color(0xFFDFA3F3);
      calcOverlayColor = const Color(0xFFCE90F0);
      calcTextColor = const Color(0xFF591D6B);
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
