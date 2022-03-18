import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'user.dart';

// ignore: avoid_classes_with_only_static_members
class LocalStorageHelper {
  //Shared prefences
  static Future sharedPrefencesSetInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future sharedPrefencesSetDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  static Future sharedPrefencesSetBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future sharedPrefencesSetString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future sharedPrefencesSetStringList(
      String key, List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, values);
  }

  static Future<dynamic> sharedPrefencesGetData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static Future<int?> sharedPrefencesGetInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return prefs.getInt(key);
    } else {
      return null;
    }
  }

  static Future<double?> sharedPrefencesGetDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return prefs.getDouble(key);
    } else {
      return null;
    }
  }

  static Future<bool?> sharedPrefencesGetBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return prefs.getBool(key);
    } else {
      return null;
    }
  }

  static Future<String?> sharedPrefencesGetString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return prefs.getString(key);
    } else {
      return null;
    }
  }

  static Future<List<String>?> sharedPrefencesGetStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return prefs.getStringList(key);
    } else {
      return null;
    }
  }

  static Future sharedPrefencesRemoveData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  //Write and read file
  static late String _fileName;
  static String get _getFileName {
    return _fileName;
  }

  static void _setFileName(String filename) {
    _fileName = filename;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_getFileName.txt');
  }

  static Future<File> writeToFile(String fileName, dynamic data) async {
    _setFileName(fileName);
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$data');
  }

  static Future<String> readFromFile(String filename) async {
    try {
      _setFileName(filename);
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      print(contents);
      return contents;
    } catch (e) {
      // If encountering an error, return ""
      return '';
    }
  }

  //SQLite
  static late String _databasebName = '';

  static late String _tableName = '';

  static late String _arguments = '';

  static late int _sqliteVersion = -1;

  static bool _databaseCreated() {
    if (_databasebName == '' || _tableName == '' || _sqliteVersion == -1) {
      return false;
    } else {
      return true;
    }
  }

  //Create a table in SQLite
  static Future<Database> createDatabase(
      String db, String table, String arg, int version) async {
    final String path = await getDatabasesPath();
    _databasebName = db;
    _tableName = table;
    _arguments = arg;
    _sqliteVersion = version;
    return openDatabase(join(path, '$db.db'),
        onCreate: (database, version) async {
      await database.execute(
        arg,
      );
    }, version: version);
  }

  static Future<Database?> _initializeDB() async {
    if (!_databaseCreated()) {
      return null;
    }
    final String path = await getDatabasesPath();
    return openDatabase(join(path, '$_databasebName.db'),
        onCreate: (database, version) async {
      await database.execute(
        _arguments,
      );
    }, version: _sqliteVersion);
  }

  //Saving data in SQLite
  static Future<int> insertRow(String table, List<dynamic> dataList) async {
    int result = 0;
    final Database? db = await _initializeDB();
    if (db == null) {
      print('null');
      return -1;
    } else {
      for (var user in dataList) {
        result = await db.insert(table, user.toMap());
      }
      return result;
    }
  }

  //Retrieve data from SQLite
  static Future<List<Object>?> retrieveTable(String table) async {
    final Database? db = await _initializeDB();
    if (db == null) {
      return null;
    } else {
      final List<Map<String, Object?>> queryResult = await db.query(table);
      return queryResult.map((e) => User.fromMap(e)).toList();
    }
  }

  //Delete data from SQLite
  static Future<void> deleteRowByID(String table, int id) async {
    final Database? db = await _initializeDB();
    try {
      await db!.delete(table, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error: $e');
    }
  }

  //Delete data from SQLite
  static Future<void> deleteRowByKey(
      String table, dynamic key, String object) async {
    final Database? db = await _initializeDB();
    try {
      await db!.delete(table, where: '$key = ?', whereArgs: [object]);
    } catch (e) {
      print('Error: $e');
    }
  }
}
