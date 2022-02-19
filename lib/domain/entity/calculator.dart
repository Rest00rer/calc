class Calc {
  final String equation;
  final String result;
  final String expression;
  final double equationFontSize;
  final double resultFontSize;
  

  Calc(this.equation, this.result, this.expression, this.equationFontSize, this.resultFontSize);

  Calc copyWith({
    String? equation,
    String? result,
    String? expression,
    double? equationFontSize,
    double? resultFontSize,
  }) {
    return Calc(equation ?? this.equation, result ?? this.result, expression ?? this.expression, equationFontSize ?? this.equationFontSize,resultFontSize ?? this.resultFontSize);
  }
}
