import 'dart:math';
import 'package:flutter/material.dart';

class CalculatorTab extends StatefulWidget {
  CalculatorTab({Key key, this.title}) : super(key: key);

  static const diceTypes = [100, 20, 12, 10, 8, 6, 4, 3, 2];
  final String title;

  @override
  _CalculatorTabState createState() => _CalculatorTabState();
}

class _CalculatorTabState extends State<CalculatorTab> {
  var _equationString = '';
  var _totalResultString = '_';
  var _totalResult = 0;
  var _rolled = false;

  void _onRollButtonClick() {
    setState(() {
      final oldRolled = _rolled;
      tryClear();

      _totalResultString = oldRolled ? '_' : "= $_totalResult";
      _rolled = true;
    });
  }

  void onDiceButtonClick(int diceType) {
    setState(() {
      tryClear();

      _totalResult += randomize(diceType);

      if (_equationString.isNotEmpty) {
        _equationString += '+';
      }
      _equationString += "d$diceType";
    });
  }

  void tryClear() {
    if (_rolled) {
      _equationString = '';
      _totalResultString = '_';
      _totalResult = 0;
      _rolled = false;
    }
  }

  int randomize(int diceType) {
    return new Random().nextInt(diceType) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 110,
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              _equationString.isEmpty
                  ? "Let's role some dice!"
                  : _equationString,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                _totalResultString,
                style: TextStyle(
                  fontSize: 80,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 190,
            width: 1000,
            child: GridView.count(
              childAspectRatio: 2.2,
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              children: List.generate(
                9,
                (index) => ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    onDiceButtonClick(CalculatorTab.diceTypes[index]);
                  },
                  child: Text('d${CalculatorTab.diceTypes[index]}'),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onRollButtonClick,
                    child: Text(
                      'Roll',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
