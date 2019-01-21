import 'package:flutter/material.dart';

class AppHeader extends AppBar {
  AppHeader({
    Key key,
    String title,
    Brightness brightness,
  }) : super(
          key: key,
          title: new Text(title),
          brightness: brightness ?? Brightness.light,
        );
}
