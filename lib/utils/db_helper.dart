import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

import '../models/label.dart';
import '../models/transaction.dart';

class DBHelper {
  static const _transactionsTableName = 'transactions_history';
  static const _labelsTableName = 'labels';
  static const _onboardingTableName = 'onboarding';
  static const _settingsTableName = 'settings';

  // onboarded wil be 0 if this is the first time the user is opening the app, 1 otherwise.
  static const _createOnBoardingTable = '''CREATE TABLE onboarding(
      id INTEGER PRIMARY KEY,
      onboarded INTEGER
    )''';

  static const _createSettingsTable = '''CREATE TABLE settings(
      id INTEGER PRIMARY KEY,
      showCurrency INTEGER,
      currency TEXT
    )''';

  static Future<sql.Database> get _database async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'bml.db'),
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: 3,
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
      labelType INTEGER)''');

    await db.execute(_createOnBoardingTable);

    await db.execute(_createSettingsTable);
  }

  static Future<void> _onUpgrade(
      sql.Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      db.execute(_createOnBoardingTable);
    }
    if (oldVersion < 3) {
      db.execute(_createSettingsTable);
      // Make the default value a dollar symbol.
      db.insert(
        _settingsTableName,
        {'id': 1, 'currency': '\$', 'showCurrency': 1},
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    }
  }

  static Future<void> insertTransaction(Transaction transaction) async {
    (await _database).insert(
      _transactionsTableName,
      transaction.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateTransaction(Transaction transaction) async {
    (await _database).update(
      _transactionsTableName,
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  static Future<void> deleteTransaction(String id) async {
    (await _database).delete(
      _transactionsTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Transaction>> getTransactions() async {
    final transactionMaps =
        await (await _database).query(_transactionsTableName);

    return List.generate(
      transactionMaps.length,
      (index) {
        return Transaction.fromMap(transactionMaps[index]);
      },
    );
  }

  static Future<void> insertLabel(Label label) async {
    (await _database).insert(
      _labelsTableName,
      label.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateLabel(Label label) async {
    (await _database).update(
      _labelsTableName,
      label.toMap(),
      where: 'id = ?',
      whereArgs: [label.id],
    );
  }

  static Future<void> deleteLabel(String id) async {
    (await _database).delete(
      _labelsTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Label>> getLabels() async {
    final labelMaps = await (await _database).query(_labelsTableName);

    return List.generate(
      labelMaps.length,
      (index) {
        return Label.fromMap(labelMaps[index]);
      },
    );
  }

  static Future<Map<String, dynamic>> getSettingsMap() async {
    final settingsMap = await (await _database).query(_settingsTableName);
    // There's only 1 row, just return that one.
    return settingsMap[0];
  }

  // Keeping this vague for now in case there's more settings in the future.
  static Future<void> updateSettings(Map<String, dynamic> updatedSettings) async {
    (await _database).update(
      _settingsTableName,
      updatedSettings,
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  static Future<bool> isOnboarded() async {
    final onboardingMaps = await (await _database).query(_onboardingTableName);

    // If the onboarding row doesn't exist, make one and assume the user hasn't onboarded.
    if (onboardingMaps.length == 0) {
      (await _database).insert(
        _onboardingTableName,
        {'id': 1, 'onboarded': 0},
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
      return false;
    }
    return onboardingMaps[0]['onboarded'] == 1;
  }

  static Future<void> onboardedUser() async {
    (await _database).update(
      _onboardingTableName,
      {'id': 1, 'onboarded': 1},
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}
