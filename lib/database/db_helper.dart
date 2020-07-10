import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static const transactionsTableName = 'transactions_history';
  static const labelsTableName = 'labels';

  static Future<sql.Database> get _database async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'bml.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  static Future<void> _onCreate(sql.Database db, int version) async {
    await db.execute('''CREATE TABLE transactions_history(
      id TEXT PRIMARY KEY,
      title TEXT,
      description TEXT,
      amount REAL,
      date INTEGER,
      labelId TEXT)''');

    // The labelType will be 0 if income, 1 if expense.
    await db.execute('''CREATE TABLE labels(
      id TEXT PRIMARY KEY,
      title TEXT,
      color INTEGER,
      label_type INTEGER
      ''');
  }
}
