import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_item.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';

class ActionList extends StatelessWidget {
  ActionList({Key key, this.actions, this.onRemove}) : super(key: key);

  final List<ActionModel> actions;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    return this.actions?.length == 0
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "It's empty in here.",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  "Try adding new action \n or switch to another user.",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : Scrollbar(
            child: ListView.builder(
              itemCount: actions?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: ActionItem(
                    model: actions[index],
                    onRemove: onRemove,
                  ),
                );
              },
            ),
          );
  }
}
