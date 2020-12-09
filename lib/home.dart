import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/widgets/action_form.dart';
import 'package:rpg_manager_flutter/widgets/action_list.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';
import 'package:rpg_manager_flutter/models/user_storage.dart';
import 'package:rpg_manager_flutter/widgets/calculator_tab.dart';
import 'package:rpg_manager_flutter/widgets/delete_user_form.dart';
import 'package:rpg_manager_flutter/widgets/new_user_form.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, @required this.storage}) : super(key: key);

  final String title;
  final UserStorage storage;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String currentUser = 'Anonymous';

  List<String> users = ['Anonymous'];
  List<ActionModel> actions = [];

  TabController _tabController;

  int _selectedIndex = 1;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
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
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: new TabBar(
            controller: _tabController,
            tabs: <Tab>[
              Tab(child: Text('Actions')),
              Tab(child: Text('Calculator')),
            ],
          ),
          title: Row(
            children: [
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
              Container(
                constraints: BoxConstraints(maxHeight: 40, maxWidth: 60),
                padding: EdgeInsets.only(left: 10),
                child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    child: Icon(Icons.person_add_alt_1),
                    onPressed: () => _showNewUserDialog()),
              ),
              (this.currentUser == "Anonymous"
                  ? Text("")
                  : Container(
                      constraints: BoxConstraints(maxHeight: 40, maxWidth: 60),
                      padding: EdgeInsets.only(left: 10),
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Icon(Icons.person_remove),
                        onPressed: () => _deleteUser(),
                      ),
                    )),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Tab>[
            Tab(
              child: Center(
                child: ActionList(
                    actions: this.actions,
                    onRemove: (action) {
                      setState(() {
                        this.actions.remove(action);
                      });
                      widget.storage.saveActions(this.actions);
                    }),
              ),
            ),
            Tab(child: CalculatorTab()),
          ],
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () => _addAction(context),
                tooltip: 'Add actions',
                child: Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
