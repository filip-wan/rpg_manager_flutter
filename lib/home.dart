import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_form.dart';
import 'package:rpg_manager_flutter/widgets/action_list.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';
import 'package:rpg_manager_flutter/models/user_storage.dart';
import 'package:rpg_manager_flutter/widgets/delete_user_form.dart';
import 'package:rpg_manager_flutter/widgets/new_user_form.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, @required this.storage}) : super(key: key);

  final String title;
  final UserStorage storage;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentUser = 'Anonymous';

  List<String> users = ['Anonymous'];
  List<ActionModel> actions = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _loadActions();
  }

  void _loadActions() {
    widget.storage.loadActions().then((List<ActionModel> value) {
      setState(() {
        if (value != null) this.actions = value;
      });
    });
  }

  void _loadUsers() {
    widget.storage.loadUsers().then((List<String> value) {
      setState(() {
        if (value != null) this.users = value;
        if (widget.storage.currentUser != null)
          this.currentUser = widget.storage.currentUser;
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
    _loadActions();
  }

  void _showNewUserDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => NewUserForm(
        userList: this.users,
        onSaved: (String userName) {
          setState(() {
            this.users.add(userName);
            this.currentUser = userName;
          });
          widget.storage.saveUsers(this.users, this.currentUser);
          _loadActions();
        },
      ),
    );
  }

  void _deleteUser() {
    if (this.currentUser == "Anonymous") return;
    showDialog(
      context: context,
      builder: (BuildContext context) => DeleteUserForm(
        user: this.currentUser,
        onDeleted: (String userName) {
          setState(() {
            this.users.remove(userName);
            this.currentUser = this.users.last;
          });
          widget.storage.removeUser(userName);
          widget.storage.saveUsers(this.users, this.currentUser);
          _loadActions();
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
        (this.currentUser == "Anonymous"
            ? Text("")
            : Container(
                constraints: BoxConstraints(maxHeight: 40, maxWidth: 60),
                padding: EdgeInsets.only(left: 10),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Icon(Icons.delete_forever),
                  onPressed: () => _deleteUser(),
                ),
              )),
        Container(
          constraints: BoxConstraints(maxHeight: 40, maxWidth: 60),
          padding: EdgeInsets.only(left: 10),
          child: FlatButton(
              color: Theme.of(context).primaryColor,
              child: Icon(Icons.add),
              onPressed: () => _showNewUserDialog()),
        ),
      ])),
      body: Center(
        child: ActionList(
            actions: this.actions,
            onRemove: (action) {
              setState(() {
                this.actions.remove(action);
              });
              widget.storage.saveActions(this.actions);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAction(context),
        tooltip: 'Add actions',
        child: Icon(Icons.add),
      ),
    );
  }
}
