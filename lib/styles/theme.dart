import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/styles/colors.dart';

ThemeData buildThemeData() => ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        color: colors["navbar"],
        brightness: Brightness.dark,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: colors["button"],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      ),
      textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.normal,
              color: colors["text"]),
          headline2: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.normal,
              color: colors["text"]),
          button: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.normal,
          )),
      brightness: Brightness.dark,
      backgroundColor: colors["background"],
      primaryColor: colors["background"],
      accentColor: colors["text"],
      canvasColor: colors["background"],
      buttonColor: colors["button"],
    );
