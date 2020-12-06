import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_form.dart';
import 'package:rpg_manager_flutter/widgets/action_list.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';
import 'package:rpg_manager_flutter/models/user_storage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, @required this.storage}) : super(key: key);

  final String title;
  final UserStorage storage;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentUser;

  List<String> users;
  List<ActionModel> actions;

  @override
  void initState() {
    super.initState();
    widget.storage.loadActions().then((List<ActionModel> value) {
      setState(() {
        this.actions = value == null ? [] : value;
      });
    });
    widget.storage.loadUsers().then((List<String> value) {
      setState(() {
        this.users = value == null ? ['Default user', 'lol'] : value;
        this.currentUser = widget.storage.currentUser == null
            ? 'Default user'
            : widget.storage.currentUser;
      });
    });
  }

  void _addAction(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ActionForm(
        model: new ActionModel(),
        onSaved: (ActionModel actionModel) {
          setState(() {
            this.actions.add(actionModel);
            widget.storage.saveActions(actions);
          });
        },
      ),
    );
  }

  void _switchUser(newValue) {
    setState(() {
      this.currentUser = newValue;
      widget.storage.saveUsers(this.users, this.currentUser);
    });
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
            onChanged: (String newValue) => _switchUser(newValue),
            value: currentUser,
            icon: Icon(Icons.arrow_downward),
            items: this
                .users
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
        child: ActionList(actions: this.actions),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAction(context),
        tooltip: 'Add actions',
        child: Icon(Icons.add),
      ),
    );
  }
}
