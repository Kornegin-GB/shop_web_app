import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/database_update_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseApp {
  final String _databaseName = 'favourite_database.db';
  final int _databaseVersion = 1;
  final String _tableFavourite = 'favorites';
  final String _columnId = 'id';

  String get columnId => _columnId;

  String get tableFavourite => _tableFavourite;

  static final DatabaseApp db = DatabaseApp._();

  DatabaseApp._();

  var _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  ///Создание базы данных
  initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        for (int ver = 1; ver <= version; ver++) {
          DatabaseUpdateList().dbOperationsVersion(db, ver);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) {
        for (int version = oldVersion + 1; version <= newVersion; version++) {
          DatabaseUpdateList().dbOperationsVersion(db, version);
        }
      },
    );
  }

  ///Внесение записи в базу данных
  insertProduct(Product product, String tableName) async {
    final db = await database;
    return await db.insert(
      tableName,
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///Чтение всех записей из базы данных
  showAllProducts(String tableName) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Product.fromJson(maps[i]);
    });
  }

  ///Проверяем есть ли запись в базе данных
  isNotEmptyProduct(int id) async {
    final db = await database;
    var result = await db.query(
      tableFavourite,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? true : false;
  }

  ///Удаление записи из базы данных
  deleteProduct(int id, String tableName) async {
    final db = await database;
    await db.delete(
      tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  ///Закрытие соединения с базой данных
// closeDB() async {
//   final db = await database;
//   db.close();
// }
}
