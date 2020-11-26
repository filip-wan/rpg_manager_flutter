import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_list.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _addAction() {
    setState(() {});
  }

  var userActions = [
    ActionModel('Greataxe attack', 'Deals 1d12+3 damage', '1d12+3'),
    ActionModel('Greataxe attack', 'Deals 1d12+3 damage', '1d12+3'),
    ActionModel('Greataxe attack', 'Deals 1d12+3 damage', '1d12+3'),
  ];

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
        onPressed: _addAction,
        tooltip: 'Add actions',
        child: Icon(Icons.add),
      ),
    );
  }
}
