import 'package:flutter/material.dart';
import 'package:flutter_weather/core/models/themeModel.dart';
import 'package:provider/provider.dart';

class PassTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final IconData icon;
  final bool passwordVisible;
  final Function onPressed;

  const PassTextInput({
    required this.onPressed,
    required this.passwordVisible,
    required this.icon,
    required this.controller,
    required this.hintText,
    required this.labelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {



    return TextFormField(
      obscureText: passwordVisible,
      controller: controller,
      cursorColor: Provider.of<ThemeModel>(context).currentTheme.primaryColor,
      style: Provider.of<ThemeModel>(context)
          .currentTheme
          .textTheme
          .bodyMedium
          ?.copyWith(
          fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Arial'),
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding:
            const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Icon(
              icon,
              color: Provider.of<ThemeModel>(context)
                  .currentTheme
                  .colorScheme
                  .onError,
              size: 30,
            ),
          ),
          suffixIcon: Padding(
            padding:
            const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: IconButton(
              icon: Icon(passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
                color: Provider.of<ThemeModel>(context)
                    .currentTheme
                    .colorScheme
                    .onError,
                size: 30,
              ),
              onPressed: () => onPressed(),
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Provider.of<ThemeModel>(context)
                .currentTheme
                .colorScheme
                .secondary,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Provider.of<ThemeModel>(context).currentTheme.primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Provider.of<ThemeModel>(context).currentTheme.primaryColor,
            ),
          ),
          labelText: labelText,
          labelStyle: Provider.of<ThemeModel>(context)
              .currentTheme
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 18)),
    );
  }
}