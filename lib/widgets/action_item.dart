import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';
import 'package:rpg_manager_flutter/widgets/action_dice_roll.dart';

class ActionItem extends StatelessWidget {
  ActionItem({Key key, this.model, this.onRemove}) : super(key: key);

  final ActionModel model;
  final Function onRemove;

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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Container(
                        constraints:
                            BoxConstraints(maxHeight: 40, maxWidth: 40),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            color: Theme.of(context).primaryColor,
                            icon: Icon(Icons
                                .highlight_remove_outlined), //person_remove
                            onPressed: () {
                              onRemove(model);
                            }),
                      ),
                    ]),
                Text(model.description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        var scaffold = Scaffold.of(context);
                        scaffold.hideCurrentSnackBar();
                        scaffold.showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(context).primaryColorDark,
                            content: ActionDiceRoll(model: model),
                            action: SnackBarAction(
                              textColor: Theme.of(context).accentColor,
                              label: "OK",
                              onPressed: () => scaffold.hideCurrentSnackBar(),
                            ),
                          ),
                        );
                      },
                      child: Text('Roll ${model.diceEquation}'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
