import 'package:flutter/material.dart';

class ThemeConfiguration {
  static const String fontFamily = 'Star Jedi';

  static ThemeData applyCustomization(ThemeData original) {
    return original.copyWith(
      textTheme: original.textTheme.apply(
        fontFamily: fontFamily,
      ),
      primaryTextTheme: original.textTheme.apply(
        fontFamily: fontFamily,
      ),
    );
  }
}
