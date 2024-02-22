import 'package:function_tree/function_tree.dart';

class CalcUtils {
  static String parseAndCalcResult(String expression) {
    final modifiedExppression = expression.replaceAll('%', '/100*');
    return '${modifiedExppression.interpret()}';
  }
}
