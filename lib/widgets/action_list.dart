import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_item.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';

class ActionList extends StatelessWidget {
  ActionList({Key key, this.actions}) : super(key: key);

  final List<ActionModel> actions;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: actions.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: ActionItem(
              model: actions[index],
            ),
          );
        },
      ),
    );
  }
}
