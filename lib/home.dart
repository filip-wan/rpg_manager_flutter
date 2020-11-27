import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_form.dart';
import 'package:rpg_manager_flutter/widgets/action_list.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userActions = [
    ActionModel(
        name: 'Greataxe attack',
        description: 'Deals 1d12+3 damage',
        diceEquation: '1d12+3'),
    ActionModel(
        name: 'Greataxe attack',
        description: 'Deals 1d12+3 damage',
        diceEquation: '1d12+3'),
    ActionModel(
        name: 'Greataxe attack',
        description: 'Deals 1d12+3 damage',
        diceEquation: '1d12+3'),
  ];

  void _addAction(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ActionForm(
        model: new ActionModel(),
        onSaved: (ActionModel actionModel) {
          this.userActions.add(actionModel);
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: getActionList(context, userActions),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAction(context),
        tooltip: 'Add actions',
        child: Icon(Icons.add),
      ),
    );
  }
}
