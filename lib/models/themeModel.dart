import 'package:flutter/material.dart';
import 'package:flutter_weather/themes/theme.dart';

enum ThemeType{
  original,
}

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = original;
  final ThemeType _themeType = ThemeType.original;
}