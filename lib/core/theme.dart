import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.brown,
      scaffoldBackgroundColor: Colors.brown[300],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.yellowAccent,
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