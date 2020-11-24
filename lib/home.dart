import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: getActionList(context, [])),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAction,
        tooltip: 'Add actions',
        child: Icon(Icons.add),
      ),
    );
  }
}
