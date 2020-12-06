import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/styles/colors.dart';

ThemeData buildThemeData() => ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      color: colors["navbar"],
      brightness: Brightness.dark,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: colors["primary"],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: colors["primary"],
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colors["primary"],
      foregroundColor: colors["text"],
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 100, fontWeight: FontWeight.normal, color: colors["text"]),
      headline2: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.normal,
        color: colors["text"],
      ),
      button: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: colors["text"],
      ),
    ),
    brightness: Brightness.dark,
    backgroundColor: colors["background"],
    primaryColor: colors["primary"],
    accentColor: colors["text"],
    canvasColor: colors["background"],
    buttonColor: colors["primary"],
    primaryColorDark: colors["navbar"],
    errorColor: colors['danger']);
