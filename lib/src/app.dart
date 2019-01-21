import 'package:flutter/material.dart';
import 'ui/scenes/index.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
