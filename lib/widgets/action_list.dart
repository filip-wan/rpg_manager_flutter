import 'package:flutter/material.dart';

Widget getActionList(BuildContext context, List<Widget> items) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Stary najebany zesrał się that many times:',
        ),
        Text(
          'elo',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
