import 'package:flutter/material.dart';
import 'package:flutter_weather/core/models/themeModel.dart';
import 'package:provider/provider.dart';

class ErrorSnackBar{
  final String descriptionText;

  ErrorSnackBar({
    required this.descriptionText,
  });

  static show(
      BuildContext context,
      String descriptionText,
      ){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
        descriptionText,
        textAlign: TextAlign.center,
        style: Provider.of<ThemeModel>(
            context,
            listen: false
        )
            .currentTheme
            .textTheme
            .bodyMedium
            ?.copyWith(fontSize: 18),
      ),
        backgroundColor: Provider.of<ThemeModel>(
            context,
            listen: false
        )
            .currentTheme
            .colorScheme
            .onSurface,
      ),
    );
  }
}