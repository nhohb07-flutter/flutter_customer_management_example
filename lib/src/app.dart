import 'package:flutter/material.dart';
import 'theme.dart';
import 'ui/scenes/index.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: Scaffold(
        body: CustomerList(),
      ),
    );
  }
}
