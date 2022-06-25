import 'dart:convert';

import 'package:ssurade/crawling/USaintSession.dart';
import 'package:ssurade/filesystem/FileSystem.dart';

class Setting {
  late USaintSession saintSession;
  bool refreshGradeAutomatically;

  Setting(String number, String password, this.refreshGradeAutomatically) {
    saintSession = USaintSession(number, password);
  }

  static const String _filename = "settings.json"; // internal file name
  static const String _number = "number", _password = "password", _refreshGradeAutomatically = "refreshGradeAutomatically"; // field schema

  static Future<Setting> loadFromFile() async {
    if (!await existFile(_filename)) {
      return Setting("", "", false);
    }

    var data = jsonDecode((await getFileContent(_filename))!);
    return Setting(data[_number] ?? "", data[_password] ?? "", data[_refreshGradeAutomatically] ?? false);
  }

  saveFile() => writeFile(
      _filename,
      jsonEncode({
        _number: saintSession.number,
        _password: saintSession.password,
        _refreshGradeAutomatically: refreshGradeAutomatically,
      }));

  @override
  String toString() {
    return "Setting(saint_session=$saintSession, refreshGradeAutomatically=$refreshGradeAutomatically)";
  }
}
