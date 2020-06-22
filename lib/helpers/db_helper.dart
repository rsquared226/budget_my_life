import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

import '../models/transaction.dart';

class DBHelper {
  static const _tableName = 'transaction_history';

  static Future<sql.Database> get _database async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'transactions.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE transaction_history(id TEXT PRIMARY KEY, title TEXT, description TEXT, amount REAL, date INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(Transaction transaction) async {
    (await _database).insert(
      _tableName,
      transaction.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(Transaction transaction) async {
    (await _database).update(
      _tableName,
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  static Future<void> delete(String id) async {
    (await _database).delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    return (await _database).query(_tableName);
  }
}
