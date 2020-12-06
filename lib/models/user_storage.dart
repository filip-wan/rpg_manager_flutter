import 'package:rpg_manager_flutter/utils/file_utility.dart';
import 'package:rpg_manager_flutter/models/action_model.dart';
import 'dart:convert';

class UserStorage {
  static const String _usersFileName = 'users';
  String _actionsFileName() => '${currentUser}_actions';

  final _files = FileUtility();

  String currentUser = 'Anonymous';

  Future<List<String>> loadUsers() async {
    String jsonString = await _files.read(
      _usersFileName,
      '{"users": [], "active": "none"}',
    );
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    currentUser = jsonMap['active'];

    List<String> users = jsonMap['users']
        .map<String>((jsonUser) => jsonUser.toString())
        .toList();
    return users;
  }

  void saveUsers(List<String> users, String currentUser) {
    this.currentUser = currentUser;

    final jsonMap = {'users': users, 'active': currentUser};
    String jsonString = jsonEncode(jsonMap);
    _files.write(jsonString, _usersFileName);
  }

  void removeUser(String currentUser) {
    this.currentUser = currentUser;

    _files.remove('${currentUser}_actions');
  }

  Future<List<ActionModel>> loadActions() async {
    String jsonString = await _files.read(
      _actionsFileName(),
      '{"actions": []}',
    );
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    List<ActionModel> actions = jsonMap['actions']
        .map<ActionModel>((action) => ActionModel.fromJson(action))
        .toList();
    return actions;
  }

  void saveActions(List<ActionModel> actions) {
    final jsonMap = {'actions': actions};
    String jsonString = jsonEncode(jsonMap);
    _files.write(jsonString, _actionsFileName());
  }
}
