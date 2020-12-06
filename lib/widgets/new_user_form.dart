import 'package:flutter/material.dart';

class NewUserForm extends StatefulWidget {
  NewUserForm({Key key, this.userList, this.onSaved}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final Function onSaved;
  final List<String> userList;

  _NewUserForm createState() => _NewUserForm();
}

class _NewUserForm extends State<NewUserForm> {
  String userName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Form(
            key: widget._formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'What is this user\'s name?',
                        labelText: 'User Name',
                      ),
                      validator: (value) => value.isEmpty
                          ? 'You have to enter User Name'
                          : (widget.userList.contains(value)
                              ? "User Name already exists"
                              : null),
                      onSaved: (String value) {
                        setState(() {
                          userName = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      child: Text("Add User"),
                      onPressed: () {
                        if (widget._formKey.currentState.validate()) {
                          widget._formKey.currentState.save();
                          widget.onSaved(this.userName);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: -10,
            top: -5,
            child: CloseButton(),
          ),
        ],
      ),
    );
  }
}
