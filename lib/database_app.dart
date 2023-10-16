import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/database_update_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseApp extends ChangeNotifier {
  final String _databaseName = 'favourite_database.db';
  final int _databaseVersion = 1;
  final String tableFavourite = 'favorites';
  final String columnId = 'id';
  final String columnNameProduct = 'nameProduct';
  final String columnDescriptionProduct = 'descriptionProduct';
  final String columnImgProduct = 'imgProduct';
  final String columnPriceProduct = 'priceProduct';

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
  insertProduct(Product product) async {
    final db = await database;
    notifyListeners();
    return await db.insert(
      tableFavourite,
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///Чтение всех записей из базы данных
  showAllProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableFavourite);
    return List.generate(maps.length, (i) {
      return Product.fromJson(maps[i]);
    });
  }

  ///Проверяем есть ли запись в базе данных
  isFavourite(int id) async {
    final db = await database;
    var result = await db.query(
      tableFavourite,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? true : false;
  }

  ///Удаление записи из базы данных
  deleteProduct(int id) async {
    final db = await database;
    await db.delete(
      tableFavourite,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  ///Закрытие соединения с базой данных
// closeDB() async {
//   final db = await database;
//   db.close();
// }
}
