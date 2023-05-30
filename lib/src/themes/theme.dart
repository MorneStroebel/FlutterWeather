import 'package:flutter/material.dart';

ThemeData original = ThemeData(
  primaryColor: const Color(0xff38E9BB),
  colorScheme:  ColorScheme(
      brightness: Brightness.light,
      primary: const Color(0xff6949FD),
      onPrimary: const Color(0xffFFFFFF),
      secondary: const Color(0xff38E9BB),
      onSecondary: Colors.transparent,
      error: const Color(0xffFFFFFF),
      onError: const Color(0xffFFFFFF),
      background: const Color(0xffFFFFFF),
      onBackground: const Color(0xffFFFFFF),
      surface: Colors.black,
      onSurface: Colors.black.withOpacity(0.5)
  ),
  fontFamily: 'ArialRound',
  scaffoldBackgroundColor: const Color(0xFF1F1147),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xff38E9BB),
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFFFF),
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xff6949FD),
    ),
  ),
);