import 'package:flutter/material.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';
import 'dart:math';

class ActionDiceRoll extends StatelessWidget {
  ActionDiceRoll({Key key, this.model}) : super(key: key);

  final ActionModel model;

  String getRandomNumber(text) {
    var rand = (String text) =>
        ((new Random()).nextDouble() * (double.parse(text.split("d")[1])))
            .ceil();

    var throwADice = (String text) =>
        List(int.parse(text.split("d")[0] == "" ? "1" : text.split("d")[0]))
            .fold(0, (acc, data) => acc + rand(text));

    var checkDice = (String text) =>
        text.contains("d") ? throwADice(text) : int.parse(text);

    var parserMinus = (String text) {
      var textList = text.split("-");
      return textList
          .skip(1)
          .fold(checkDice(textList[0]), (acc, val) => acc - checkDice(val));
    };

    var parserPlus = (String text) {
      var textList = text.split("+");
      return textList
          .skip(1)
          .fold(parserMinus(textList[0]), (acc, val) => acc + parserMinus(val));
    };

    return (parserPlus(text).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            "You rolled",
            style:
                TextStyle(fontSize: 20, color: Theme.of(context).buttonColor),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5),
          child: Text(getRandomNumber(model.diceEquation),
              style: TextStyle(
                  fontSize: 50, color: Theme.of(context).buttonColor)),
        ),
      ],
    );
  }
}
