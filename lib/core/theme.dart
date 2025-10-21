import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.orangeAccent,
      scaffoldBackgroundColor: Colors.brown[300],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}