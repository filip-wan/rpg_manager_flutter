import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';

class ActionForm extends StatelessWidget {
  ActionForm({Key key, this.model, this.onSaved}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final Function onSaved;
  final ActionModel model;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(18, 10, 18, 10),
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -15,
            top: -15,
            child: CloseButton(),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.zero,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'What is this action\'s name?',
                      labelText: 'Action Name',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'You have to enter Action Name' : null,
                    onSaved: (String value) {
                      model.name = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'What does this action do?',
                      labelText: 'Description',
                    ),
                    onSaved: (String value) {
                      model.description = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'What happens on dice throw?',
                      labelText: 'Dice Equation',
                    ),
                    validator: (value) => value.isEmpty
                        ? 'You have to enter Dice Equation'
                        : null,
                    onSaved: (String value) {
                      model.diceEquation = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    child: Text("Add Action"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        onSaved(this.model);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
