import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_item.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';

Widget getActionList(BuildContext context, List<ActionModel> actionModels) =>
    ListView(
      children: actionModels.map((m) => ActionItem(model: m)).toList(),
      padding: EdgeInsets.only(bottom: 100.0),
    );
