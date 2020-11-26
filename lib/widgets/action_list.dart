import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_item.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';

Widget getActionList(BuildContext context, List<ActionModel> actionModels) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: actionModels.map((m) => ActionItem(model: m)).toList());
}
