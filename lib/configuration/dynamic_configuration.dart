import 'package:flutter/material.dart';

/// Global InheritedWidget to access the data of the plugin
/// Current Theme related data or methods
class DynamicConfiguration extends InheritedWidget {
  final DynamicConfigurationWidgetState data;

  const DynamicConfiguration({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static DynamicConfigurationWidgetState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DynamicConfiguration>()!
        .data;
  }

  @override
  bool updateShouldNotify(DynamicConfiguration oldWidget) {
    return this != oldWidget;
  }
}

/// Widget that will contains the whole app
class DynamicConfigurationWidget extends StatefulWidget {
  final ThemeMode? initialThemeMode;
  final Locale? defaultLocale;
  final Widget child;

  const DynamicConfigurationWidget(
      {Key? key,
      this.initialThemeMode,
      this.defaultLocale,
      required this.child})
      : super(key: key);

  @override
  DynamicConfigurationWidgetState createState() =>
      DynamicConfigurationWidgetState();
}

class DynamicConfigurationWidgetState
    extends State<DynamicConfigurationWidget> {
  ThemeMode themeMode = ThemeMode.system;

  /// Change your current ThemeMode
  ///
  void changeTheme(bool dark) {
    setState(() {
      themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void revertToDefault() {
    setState(() {
      themeMode = ThemeMode.system;
    });
  }

  bool get isDark => themeMode == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return DynamicConfiguration(
      data: this,
      child: widget.child,
    );
  }
}
