import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: const Color(0xFF2DBA4E), // GitHub green
      scaffoldBackgroundColor:
          const Color(0xFF0D1117), // GitHub dark background
      cardColor: const Color(0xFF161B22), // GitHub card background
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF161B22),
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        subtitle1: TextStyle(color: Color(0xFF58A6FF)), // GitHub blue
        bodyText1: TextStyle(color: Color(0xFFC9D1D9)),
        bodyText2: TextStyle(color: Color(0xFF8B949E)),
      ),
    );
  }
}
