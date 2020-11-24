import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/styles/theme.dart';
import 'package:rpg_manager_flutter/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG Manager',
      theme: buildThemeData(),
      home: HomePage(title: 'Action List'),
    );
  }
}
