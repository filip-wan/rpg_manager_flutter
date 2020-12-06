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
      contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'What is this action\'s name?',
                        labelText: 'Action Name',
                      ),
                      validator: (value) => value.isEmpty
                          ? 'You have to enter Action Name'
                          : null,
                      onSaved: (String value) {
                        model.name = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
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
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'What happens on dice throw?',
                        labelText: 'Dice Equation',
                      ),
                      validator: (value) {
                        var regex =
                            RegExp(r'^(([0-9]+)|([0-9]+d[0-9]+)|(d[0-9]+))$');

                        var validator = (text) {
                          bool isInvalid = false;
                          text.split("+").forEach((element) {
                            element.split("-").forEach((e) {
                              isInvalid = isInvalid || !regex.hasMatch(e);
                            });
                          });
                          return isInvalid;
                        };

                        return value.isEmpty
                            ? 'You have to enter Dice Equation'
                            : (validator(value)
                                ? "Wrong Equation format"
                                : null);
                      },
                      onSaved: (String value) {
                        model.diceEquation = value;
                      },
                    ),
                  ),
                  Container(
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
