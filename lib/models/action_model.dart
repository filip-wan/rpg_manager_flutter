class ActionModel {
  String name, description, diceEquation;
  ActionModel({this.name = "", this.description = "", this.diceEquation = ""});

  ActionModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        diceEquation = json['diceEquation'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'diceEquation': diceEquation,
      };
}
