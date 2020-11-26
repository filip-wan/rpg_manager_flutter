import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';

class ActionItem extends StatelessWidget {
  ActionItem({Key key, this.model}) : super(key: key);

  final ActionModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          model.name,
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(model.description),
        RaisedButton(
          onPressed: null,
          child: Text(model.diceEquation),
        ),
      ],
    );
  }
}
