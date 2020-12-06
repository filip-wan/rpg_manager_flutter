import 'package:flutter/material.dart';

class DeleteUserForm extends StatelessWidget {
  DeleteUserForm({Key key, this.user, this.onDeleted}) : super(key: key);

  final Function onDeleted;
  final String user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Do you want to remove user " + user + "?",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        child: Text("Delete"),
                        onPressed: () {
                          onDeleted(user);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
