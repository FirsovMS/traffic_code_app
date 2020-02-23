import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' show Database, openDatabase;

class QuestionProvider {
  static final _databaseName = 'dbase.db';
  static final _databaseVersion = 1;

  static final table = 'tab_question';
  static final columnId = 'id';
  static final columnJson = 'json';

  // make this a singleton class
  QuestionProvider._();

  static final QuestionProvider instance = QuestionProvider._();

  // Properties
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  // private methods
  initializeDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY
        $columnJson BLOB NOT NULL
      )
    ''');
  }
}
