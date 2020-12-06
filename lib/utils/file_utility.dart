import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtility {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName.json');
  }

  Future<File> write(Object data, String fileName) async {
    final file = await _localFile(fileName);
    return file.writeAsString(data);
  }

  Future<String> read(String fileName, String defaultContent) async {
    final file = await _localFile(fileName);
    if (await file.exists()) {
      String contents = await file.readAsString();
      return contents;
    } else {
      await file.writeAsString(defaultContent);
      return defaultContent;
    }
  }
}
