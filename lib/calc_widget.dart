
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/services/calc_service.dart';

class ViewModelState {
  final String equation;
  final String result;
  final double equationFontSize;
  final double resultFontSize;
  ViewModelState({required this.equation, required this.result, required this.equationFontSize, required this.resultFontSize});
}

class ViewModel extends ChangeNotifier {
  final _calcService = CalcService();
  var _state = ViewModelState(equation: '1.0', result: '1.0', equationFontSize: 11.0, resultFontSize: 10.0);
  ViewModelState get state => _state;

  void loadValue() async {
    await _calcService.initialize();
    _updateState();
  }

  ViewModel() {
    loadValue();
  }

  Future<void> onButtonPressed(String text) async {
    _calcService.buttonPressed(text);
    _updateState();
  }

  void _updateState() {
    final user = _calcService.calc;
    _state = ViewModelState(
      equation: user.equation,
      result: user.result,
      equationFontSize: user.equationFontSize,
      resultFontSize: user.resultFontSize,
    );
    notifyListeners();
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.23,
              // ),
              _EquationTile(),
              _ResultTile(),
              Expanded(child: Divider()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            BuildButton(btnText: 'C', btnTextColor: Colors.orange[700]),
                            BuildButton(btnText: '⌫', btnTextColor: Colors.orange[700]),
                            BuildButton(btnText: '%', btnTextColor: Colors.orange[700]),
                            BuildButton(btnText: '÷', btnTextColor: Colors.orange[700]),
                          ],
                        ),
                        TableRow(
                          children: [
                            BuildButton(btnText: '7', btnTextColor: Colors.black),
                            BuildButton(btnText: '8', btnTextColor: Colors.black),
                            BuildButton(btnText: '9', btnTextColor: Colors.black),
                            BuildButton(btnText: '×', btnTextColor: Colors.orange[700]),
                          ],
                        ),
                        TableRow(
                          children: [
                            BuildButton(btnText: '4', btnTextColor: Colors.black),
                            BuildButton(btnText: '5', btnTextColor: Colors.black),
                            BuildButton(btnText: '6', btnTextColor: Colors.black),
                            BuildButton(btnText: '-', btnTextColor: Colors.orange[700]),
                          ],
                        ),
                        TableRow(
                          children: [
                            BuildButton(btnText: '1', btnTextColor: Colors.black),
                            BuildButton(btnText: '2', btnTextColor: Colors.black),
                            BuildButton(btnText: '3', btnTextColor: Colors.black),
                            BuildButton(btnText: '+', btnTextColor: Colors.orange[700]),
                          ],
                        ),
                        TableRow(
                          children: [
                            BuildButton(btnText: '00', btnTextColor: Colors.black),
                            BuildButton(btnText: '0', btnTextColor: Colors.black),
                            BuildButton(btnText: '.', btnTextColor: Colors.black),
                            BuildButton(btnText: '=', btnTextColor: Colors.orange[700]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EquationTile extends StatelessWidget {
  const _EquationTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final equation = context.select((ViewModel vm) => vm.state.equation);
    final equationFontSize = context.select((ViewModel vm) => vm.state.equationFontSize);
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Text(
        equation,
        softWrap: true,
        style: TextStyle(color: Colors.black, fontSize: equationFontSize),
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final result = context.select((ViewModel vm) => vm.state.result);
    final resultFontSize = context.select((ViewModel vm) => vm.state.resultFontSize);
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Text(
        result,
        style: TextStyle(color: Colors.black, fontSize: resultFontSize),
        maxLines: 1,
      ),
    );
  }
}

class BuildButton extends StatefulWidget {
  final String btnText;
  final Color? btnTextColor;

  BuildButton({Key? key, required this.btnText, required this.btnTextColor}) : super(key: key);

  @override
  State<BuildButton> createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
  bool _isElevated = true;

  bool _animEnd = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isElevated = !_isElevated;
              viewModel.onButtonPressed(widget.btnText);
            });
            _animEnd = true;
          },
          child: AnimatedContainer(
            child: Center(
              child: Text(
                widget.btnText,
                style: _isElevated ? TextStyle(fontSize: 25, fontWeight: FontWeight.normal, color: widget.btnTextColor) : TextStyle(fontSize: 21, fontWeight: FontWeight.normal, color: widget.btnTextColor),
              ),
            ),
            padding: EdgeInsets.all(16.0),
            duration: const Duration(milliseconds: 150),
            height: MediaQuery.of(context).size.height * 0.085,
            width: MediaQuery.of(context).size.height * 0.085,
            decoration: BoxDecoration(
              color: Colors.yellow[300],
              borderRadius: BorderRadius.circular(50),
              boxShadow: _isElevated
                  ? [
                      BoxShadow(
                        color: Colors.yellow[700]!,
                        offset: const Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.yellow[200]!,
                        offset: Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ]
                  : [
                      BoxShadow(
                        color: Colors.yellow[700]!,
                        offset: const Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.yellow[200]!,
                        offset: Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ],
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                Colors.yellow[200]!,
                Colors.yellow[400]!,
              ]),
            ),
            onEnd: () {
              if (_animEnd == true) {
                _animEnd = false;
                setState(() {
                  _isElevated = !_isElevated;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
