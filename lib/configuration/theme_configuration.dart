import 'package:flutter/material.dart';

class ThemeConfiguration {
  static const String fontFamily = 'DeathStar';

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
