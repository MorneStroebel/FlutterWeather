import 'package:flutter/material.dart';

ThemeData original = ThemeData(
  primaryColor: const Color(0xff38E9BB),
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff6949FD),
      onPrimary: Color(0xffFFFFFF),
      secondary: Color(0xff38E9BB),
      onSecondary: Colors.transparent,
      error: Color(0xffFFFFFF),
      onError: Color(0xffFFFFFF),
      background: Color(0xffFFFFFF),
      onBackground: Color(0xffFFFFFF),
      surface: Colors.black,
      onSurface: Color(0xffFFFFFF)
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