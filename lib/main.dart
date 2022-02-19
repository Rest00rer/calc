import 'package:flutter/material.dart';
import 'package:mscalp/calc_widget.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        backgroundColor: Colors.black,
      ),
      home: ChangeNotifierProvider(
          create: (_) {
            return ViewModel();
          },
          child: TestWidget()),
    );
  }
}

