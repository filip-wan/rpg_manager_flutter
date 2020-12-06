import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';

class ActionItem extends StatelessWidget {
  ActionItem({Key key, this.model, this.isFirstInList}) : super(key: key);

  final ActionModel model;
  final bool isFirstInList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Theme.of(context).primaryColorDark),
            color: Theme.of(context).primaryColorDark,
          ),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.name,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(model.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Roll ${model.diceEquation}'),
                  )
                ],
              ),
            ],
          ),
        )),
      ],
    );
  }
}
