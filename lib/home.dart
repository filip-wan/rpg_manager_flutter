import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_form.dart';
import 'package:rpg_manager_flutter/widgets/action_list.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';
import 'package:rpg_manager_flutter/models/user_storage.dart';
import 'package:rpg_manager_flutter/widgets/new_user_form.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, @required this.storage}) : super(key: key);

  final String title;
  final UserStorage storage;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentUser;

  List<String> users = ['Anonymous'];
  List<ActionModel> actions = [];

  @override
  void initState() {
    super.initState();
    widget.storage.loadActions().then((List<ActionModel> value) {
      if (value != null) {
        setState(() {
          this.actions = value;
        });
      }
    });
    widget.storage.loadUsers().then((List<String> value) {
      if (value != null) {
        setState(() {
          this.users = value;
          this.currentUser = widget.storage.currentUser == null
              ? 'Anonymous'
              : widget.storage.currentUser;
        });
      }
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
          });
          widget.storage.saveActions(this.actions);
        },
      ),
    );
  }

  void _switchUser(newValue) {
    setState(() {
      this.currentUser = newValue;
    });
    widget.storage.saveUsers(this.users, this.currentUser);
  }

  void _showNewUserDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => NewUserForm(
        userList: this.users,
        onSaved: (String userName) {
          setState(() {
            this.users.add(userName);
          });
          widget.storage.saveUsers(this.users, this.currentUser);
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
          flex: 6,
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
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: FlatButton(
                color: Theme.of(context).primaryColor,
                child: Icon(Icons.add),
                onPressed: () => _showNewUserDialog()),
          ),
        ),
        Expanded(flex: 6, child: Text(""))
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
