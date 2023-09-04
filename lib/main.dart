import 'package:flutter/material.dart';
import 'package:spotx/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light, // Set the default theme to light
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Set the dark theme
        primarySwatch: Colors.blue, // You can customize other colors too
      ),
      themeMode: ThemeMode.dark, // Set the initial theme mode to dark
      home: const Home(),
    );
  }
}
