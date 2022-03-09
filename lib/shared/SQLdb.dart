import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SQLdb {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'Orders';

  static final orderNumber = 'orderNumber';
  static final transactionDate = 'transactionDate';
  static final customerCode = 'customerCode';
  static final customerName = 'customerName';
  static final totalItemCount= 'totalItemCount';
  static final totalGrossAmount = 'totalGrossAmount';
  static final totalDiscountAmount = 'totalDiscountAmount';
  static final totalNetAmount = 'totalNetAmount';

  SQLdb._privateConstructor();
  static final SQLdb instance = SQLdb._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table('
            '$orderNumber INTEGER PRIMARY KEY, '
            '$transactionDate TEXT'
            '$customerCode TEXT, '
            '$customerName INTEGER'
            '$totalItemCount INTEGER'
            '$totalGrossAmount TEXT'
            '$totalDiscountAmount TEXT'
            '$totalNetAmount TEXT'

            ')'
    );
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[orderNumber];
    return await db.update(table, row, where: '$orderNumber = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$orderNumber = ?', whereArgs: [id]);
  }
}