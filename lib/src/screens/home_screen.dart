import 'package:calculator/src/components/calc_button.dart';
import 'package:calculator/src/utils/calc_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

// test comment
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String output = '';
  final List<CalcButton> tapsHistory = [];

  void allCleared() {
    setState(() {
      output = '';
    });
    tapsHistory.clear();
  }

  void handleCalcControlButtonPressed(CalcButton currentPressedButton) {
    final List<CalcButton> firstAllowed = [CalcButton.minus];
    final isFirst = tapsHistory.isEmpty;
    final isFirstTypeOperator = isFirst &&
        currentPressedButton.type == CalcButtonType.operator &&
        !firstAllowed.contains(currentPressedButton);
    final isDoubleOperators =
        currentPressedButton.type == CalcButtonType.operator &&
            tapsHistory.isNotEmpty &&
            tapsHistory.last.type == CalcButtonType.operator;

    if (isFirstTypeOperator) {
      return;
    }
    if (isDoubleOperators) {
      if (tapsHistory.length <= 1) {
        return;
      }
      final isDubleInlineAllowed =
          tapsHistory.last.inLineWith?.contains(currentPressedButton) ?? false;
      if (!isDubleInlineAllowed) {
        tapsHistory.removeLast();
      }
    }
    if (currentPressedButton == CalcButton.ac) {
      allCleared();
      return;
    }
    if (currentPressedButton == CalcButton.equal) {
      String parsedOutput = '';
      try {
        parsedOutput = CalcUtils.parseAndCalcResult(output);
      } catch (e) {
        tapsHistory.clear();
        setState(() {
          output = 'Ошибка Формата';
        });
        return;
      }
      allCleared();
      parsedOutput.split('').forEach((char) {
        final inToTapsHistory = CalcButton.values.firstWhereOrNull(
          (calcButton) => calcButton.value == char,
        );
        if (inToTapsHistory != null) {
          tapsHistory.add(inToTapsHistory);
        }
      });
      setState(() {
        output = parsedOutput;
      });
      return;
    }
    if (currentPressedButton == CalcButton.lastDelete) {
      tapsHistory.removeLast();
    }
    if (currentPressedButton.type != CalcButtonType.processing) {
      tapsHistory.add(currentPressedButton);
    }
    setState(() {
      output = tapsHistory.fold<String>('', (acc, cur) {
        return '$acc${cur.value}';
      });
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
                  CalcButtonWidget(
                    props: CalcButton.ac,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.ac.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.parentheses,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.parentheses.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.procent,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.procent.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.div,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.div.value,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcButtonWidget(
                    props: CalcButton.seven,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.seven.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.eight,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.eight.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.nine,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.nine.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.mult,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.mult.value,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcButtonWidget(
                    props: CalcButton.four,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.four.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.five,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.five.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.six,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.six.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.minus,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.minus.value,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcButtonWidget(
                    props: CalcButton.one,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.one.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.two,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.two.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.three,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.three.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.plus,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.plus.value,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcButtonWidget(
                    props: CalcButton.dot,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.dot.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.zero,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.zero.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.lastDelete,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.lastDelete.value,
                  ),
                  CalcButtonWidget(
                    props: CalcButton.equal,
                    onCalcButtonPressed: handleCalcControlButtonPressed,
                    child: CalcButton.equal.value,
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
