import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void push(Widget screen) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

extension ScreenSizeExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}