import 'package:flutter/material.dart';
import 'package:mscalp/application/ui/themes/app_theme.dart';
import 'package:provider/provider.dart';

import 'application/calc_widget.dart';


void main() {
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Calc',
      theme: AppTheme.light,
      home: ChangeNotifierProvider(
          create: (_) {
            return ViewModel();
          },
          child: TestWidget()),
    );
  }
}

