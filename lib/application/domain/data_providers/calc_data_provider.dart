
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/calculator.dart';

class CalcDataProvider {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<Calc> loadValue() async {
    // (await sharedPreferences).clear(); //!! очистить
    final equation = (await sharedPreferences).getString('equation') ?? '0';
    final result = (await sharedPreferences).getString('result') ?? '0';
    final expression = (await sharedPreferences).getString('expression') ?? '0';
    final equarionFontSize = (await sharedPreferences).getDouble('equarionFontSize') ?? 38.0;
    final resultFontSize = (await sharedPreferences).getDouble('resultFontSize') ?? 48.0;

    return Calc(equation, result, expression, equarionFontSize, resultFontSize);
  }

  Future<void> saveValue(Calc calc) async {
    (await sharedPreferences).setString('equation', calc.equation);
    (await sharedPreferences).setString('result', calc.result);
    (await sharedPreferences).setString('expression', calc.expression);
    (await sharedPreferences).setDouble('equarionFontSize', calc.equationFontSize);
    (await sharedPreferences).setDouble('resultFontSize', calc.resultFontSize);
  }
}
