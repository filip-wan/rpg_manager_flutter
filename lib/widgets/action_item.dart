import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';

class ActionItem extends StatelessWidget {
  ActionItem({Key key, this.model}) : super(key: key);

  final ActionModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.name,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(model.description),
              RaisedButton(
                onPressed: null,
                child: Text('Roll ${model.diceEquation}'),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
