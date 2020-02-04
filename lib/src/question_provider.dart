import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' show Database, openDatabase;

class QuestionProvider {
  static final databaseName = 'dbase.db';
  static final databaseVersion = 1;
  static final table = 'tab_question';
  static final columnId = 'id';
  static final columnJson = 'json';

  // make this a singleton class
  QuestionProvider._();
  static final QuestionProvider instance = QuestionProvider._();

  // Properties
  static Database _database;
  Future<Database> get database async {
    if (database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  // private methods
  initializeDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + databaseName;
    return await openDatabase(path, version: databaseVersion);
  }
}
