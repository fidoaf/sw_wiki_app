import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sw_app/configuration/dynamic_configuration.dart';
import 'package:sw_app/configuration/theme_configuration.dart';
import 'package:sw_app/view/stages/landing_page.dart';

/// SW wiki app:
/// Main entry point
void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.orangeAccent,
    systemNavigationBarColor: Colors.orangeAccent,
  ));
  runApp(const DynamicConfigurationWidget(child: MyApp()));
}

///
/// Basic Material app with adaptative theming: light and dark theme.
/// Tailor the ThemeData at this stage to affect the whole app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars fan app',
      debugShowCheckedModeBanner: false,
      // Theming configuration
      theme: ThemeConfiguration.applyCustomization(ThemeData.light()),
      darkTheme: ThemeConfiguration.applyCustomization(ThemeData.dark()),
      themeMode: DynamicConfiguration.of(context).themeMode,
      home: const LandingPage(title: 'Star Wars fan app'),
    );
  }
}
