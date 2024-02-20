import 'package:calculator/src/components/calc_button.dart';
import 'package:calculator/src/utils/calc_util.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class CalcButtonProps {
  const CalcButtonProps(this.type, this.value);

  final CalcButtonType type;
  final String value;
}

class _HomeScreenState extends State<HomeScreen> {
  String output = '';
  String num1 = '';
  String num2 = '';
  final List<CalcButtonProps> tapsHistory = [];

  void allCleared() {
    num1 = '';
    num2 = '';
    tapsHistory.clear();
  }

  double? parseAndCalcOutput() {
    bool isWriteToNum1 = true;
    String? prevOperator;

    for (final props in tapsHistory) {
      bool isNegative = false;
      if (props.value == '-') {
        final currentIndex = tapsHistory.indexOf(props);
        if (num1.isEmpty ||
            tapsHistory[currentIndex - 1].type == CalcButtonType.operator) {
          isNegative = true;
        }
      }
      if (props.type == CalcButtonType.operator && !isNegative) {
        if (!isWriteToNum1) {
          num1 = CalcUtils.caclulateResult(
                  double.parse(num1), double.parse(num2), prevOperator!)
              .toString();
          num2 = '';
        }
        isWriteToNum1 = false;
        prevOperator = props.value;
        continue;
      }
      if (isWriteToNum1) {
        num1 += props.value;
      } else {
        num2 += props.value;
      }
      print(num1 + ', ' + num2);
    }
    if (num1.isNotEmpty && num2.isNotEmpty) {
      return CalcUtils.caclulateResult(
          double.parse(num1), double.parse(num2), prevOperator!);
    }
    return null;
  }

  void handleCalcControlButtonPressed(String calcValue, CalcButtonType type) {
    final isFirst = tapsHistory.isEmpty;
    final isFirstTypeOperator = isFirst &&
        type == CalcButtonType.operator &&
        calcValue != 'AC' &&
        calcValue != '-';
    final isDoubleOperatorInLine = tapsHistory.isNotEmpty &&
        tapsHistory.last.type == CalcButtonType.operator &&
        type == CalcButtonType.operator &&
        calcValue != '-';

    if (calcValue == 'AC') {
      allCleared();
      setState(() {
        output = '';
      });
      return;
    }
    if (isFirstTypeOperator || isDoubleOperatorInLine) {
      return;
    }
    if (calcValue == '=') {
      final parsedOutput = parseAndCalcOutput();
      if (parsedOutput != null) {
        setState(() {
          output = parsedOutput.toString();
        });
        allCleared();
      }
      return;
    }

    tapsHistory.add(CalcButtonProps(type, calcValue));
    setState(() {
      output += calcValue;
    });
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
                    value: '-',
                    type: CalcButtonType.operator,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: '-',
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
