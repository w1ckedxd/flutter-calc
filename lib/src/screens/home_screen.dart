import 'package:calculator/src/components/calc_button.dart';
import 'package:calculator/src/utils/calc_util.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String output = '';
  CalcButtonType? lastPressedButtonType;
  String? lastPressedOperator;
  String num1 = '';
  String num2 = '';
  double? result;

  void handleCalcControlButtonPressed(String calcValue, CalcButtonType type) {
    final isFirst = lastPressedButtonType == null;
    if (calcValue == 'AC' || calcValue == '=') {
      result = null;
      if (output.isNotEmpty &&
          calcValue == '=' &&
          lastPressedOperator != null &&
          num1.isNotEmpty &&
          num2.isNotEmpty) {
        result = CalcUtils.caclulateResult(
          double.parse(num1),
          double.parse(num2),
          lastPressedOperator!,
        );
      }
      num1 = '';
      num2 = '';
      lastPressedButtonType = null;
      lastPressedOperator = null;
      setState(() {
        if (calcValue == 'AC') {
          output = '';
        }
        if (output != '' && calcValue == '=' && result != null) {
          output = result.toString();
        }
      });
      return;
    }
    if (lastPressedButtonType == CalcButtonType.operator &&
        type == CalcButtonType.operator) {
      return;
    }
    if (isFirst && type == CalcButtonType.operator && calcValue != '-') {
      return;
    }
    if (type == CalcButtonType.operator) {
      lastPressedOperator = calcValue;
    }
    setState(() {
      output += calcValue;
    });
    if ((type == CalcButtonType.digit || calcValue == '-') &&
        num2.isEmpty &&
        lastPressedButtonType != CalcButtonType.operator || calcValue == '-') {
      lastPressedButtonType = null;
      num1 += calcValue;
    }
    if (type == CalcButtonType.digit &&
        (lastPressedButtonType == CalcButtonType.operator || num2.isNotEmpty)) {
      num2 += calcValue;
    }

    lastPressedButtonType = type;

    print('lastPressedButtonType: $lastPressedButtonType');
    print('num1: $num1');
    print('num2: $num2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            output,
            style: const TextStyle(
              fontSize: 75,
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcButton(
                    type: CalcButtonType.operator,
                    value: 'AC',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: 'AC',
                  ),
                  CalcButton(
                    type: CalcButtonType.digit,
                    value: '0',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '0',
                  ),
                  CalcButton(
                    type: CalcButtonType.operator,
                    value: '*',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '*',
                  ),
                  CalcButton(
                    type: CalcButtonType.operator,
                    value: '/',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '/',
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcButton(
                    type: CalcButtonType.digit,
                    value: '7',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '7',
                  ),
                  CalcButton(
                    type: CalcButtonType.digit,
                    value: '8',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '8',
                  ),
                  CalcButton(
                    type: CalcButtonType.digit,
                    value: '9',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '9',
                  ),
                  CalcButton(
                    value: '=',
                    type: CalcButtonType.operator,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '=',
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcButton(
                    type: CalcButtonType.digit,
                    value: '4',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '4',
                  ),
                  CalcButton(
                    type: CalcButtonType.digit,
                    value: '5',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '5',
                  ),
                  CalcButton(
                    type: CalcButtonType.digit,
                    value: '6',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '6',
                  ),
                  CalcButton(
                    value: '-',
                    type: CalcButtonType.operator,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '-',
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcButton(
                    type: CalcButtonType.digit,
                    value: '1',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '1',
                  ),
                  CalcButton(
                    type: CalcButtonType.digit,
                    value: '2',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '2',
                  ),
                  CalcButton(
                    type: CalcButtonType.digit,
                    value: '3',
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '3',
                  ),
                  CalcButton(
                    value: '+',
                    type: CalcButtonType.operator,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '+',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
