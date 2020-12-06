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

  String dropdownValue = 'One';
  List<String> dropdownItems = ['One', 'Two', 'Free', 'Four'];

  void _addAction(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ActionForm(
        model: new ActionModel(),
        onSaved: (ActionModel actionModel) {
          setState(() {
            this.userActions.add(actionModel);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
        Expanded(
          flex: 4,
          child: DropdownButton<String>(
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            items: dropdownItems
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(flex: 5, child: Text(""))
      ])),
      body: Center(
        child: ActionList(actions: userActions),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAction(context),
        tooltip: 'Add actions',
        child: Icon(Icons.add),
      ),
    );
  }
}
