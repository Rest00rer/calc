import 'package:expressions/expressions.dart';

import '../data_providers/calc_data_provider.dart';
import '../entity/calculator.dart';
// import 'package:math_expressions/math_expressions.dart';


class CalcService {
  final _calcDataProvider = CalcDataProvider();
  Calc _calc = Calc('', '', '', 48.0, 38.0);
  Calc get calc => _calc;

  static const operators = ['/', '*', '-', '+', '%', '×', '÷'];
  static const numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '00'];

  Future<void> initialize() async {
    _calc = await _calcDataProvider.loadValue();
  }

  void evaluate() {
    _calc = calc.copyWith(expression: _calc.equation);
    _calc = calc.copyWith(expression: _calc.expression.replaceAll('×', '*').replaceAll('÷', '/'));
    if (operators.contains(calc.expression[calc.expression.length - 1])) _calc = calc.copyWith(expression: _calc.expression.substring(0, _calc.expression.length - 1));
    if (_calc.expression.endsWith('/0')) _calc = calc.copyWith(result: 'На 0 делить нельзя', resultFontSize: 38.0);
    Expression expression = Expression.parse(_calc.expression);
    // try {
    //   Parser p = Parser();
    //   Expression exp = p.parse(_calc.expression);
    //   ContextModel cm = ContextModel();
    //   _calc = calc.copyWith(result: '${exp.evaluate(EvaluationType.REAL, cm)}');
    // } catch (e) {
    //   _calc = calc.copyWith(result: 'Error');
    // }
  }

  void buttonPressed(String btnText) {
    //  C
    if (btnText == 'C') {
      _calc = calc.copyWith(equation: '0', result: '0', equationFontSize: 48.0, resultFontSize: 38.0);
    }
    // ⌫
    else if (btnText == '⌫') {
      _calc = calc.copyWith(equation: calc.equation.substring(0, calc.equation.length - 1), equationFontSize: 48.0, resultFontSize: 38.0);
      if (calc.equation == '') {
        _calc = calc.copyWith(equation: '0');
      }
    }
    // =
    else if (btnText == '=') {
      evaluate();
    }
    // %
    else if (btnText == '%') {
      if (calc.equation != '' && calc.equation != '0') {
        if (operators.contains(calc.equation[calc.equation.length - 1]) & operators.contains(btnText)) {
          _calc = calc.copyWith(equation: calc.equation.substring(0, calc.equation.length - 1));
        }
        _calc = calc.copyWith(equationFontSize: 48.0, resultFontSize: 38.0);
        if (calc.equation == '0') _calc = calc.copyWith(equation: '');
        _calc = calc.copyWith(equation: calc.equation + btnText);
      }
    }
    // -
    else if (btnText == '-') {
      if (operators.contains(calc.equation[calc.equation.length - 1])) {
        _calc = calc.copyWith(equation: calc.equation.substring(0, calc.equation.length - 1) + btnText);
      } else if (calc.equation == '' || calc.equation == '0') {
        _calc = calc.copyWith(equation: btnText);
      } else if (calc.equation[calc.equation.length - 1] != btnText) {
        _calc = calc.copyWith(equation: calc.equation + btnText);
      }
    } else
    // цифры
    if (numbers.contains(btnText)) {
        if (calc.equation == '0') _calc = calc.copyWith(equation: '');
        _calc = calc.copyWith(equation: calc.equation + btnText);
        if (calc.equation != '0') evaluate();
      
    }
    // .
    else if (btnText == '.') {
      if (calc.equation[calc.equation.length - 1] != btnText) {
        if (calc.equation == '0') {
          _calc = calc.copyWith(equation: calc.equation + btnText);
        } else
          for (int i = calc.equation.length - 1; i >= 0; i--) {
            if (i <= 1) {
              _calc = calc.copyWith(equation: calc.equation + btnText);
              break;
            }
            if (numbers.contains(calc.equation[i - 1])) {
            } else if (operators.contains(calc.equation[i - 1])) {
              _calc = calc.copyWith(equation: calc.equation + btnText);
              break;
            } else
              break;
          }
      }
    }

    // /, *, +
    else {
      if (operators.contains(calc.equation[calc.equation.length - 1])) {
        _calc = calc.copyWith(equation: calc.equation.substring(0, calc.equation.length - 1) + btnText);
      } else if (calc.equation[calc.equation.length - 1] != btnText) {
        _calc = calc.copyWith(equation: calc.equation + btnText);
      }
      if (operators.contains(calc.equation[calc.equation.length - 1])) {
        _calc = calc.copyWith(equation: calc.equation.substring(0, calc.equation.length - 1) + btnText);
      } else if (calc.equation[calc.equation.length - 1] != btnText) {
        _calc = calc.copyWith(equationFontSize: 48.0, resultFontSize: 38.0, equation: calc.equation + btnText);
      }
      if (calc.equation.length >= 2) evaluate();
    }
    _calcDataProvider.saveValue(_calc);
  }
}
//! Смена размера при приближении к маскимальному числу 
//! Проврить, есть ли оператор, после этого считать
//! Добавить разделение каждые 3 цифры
