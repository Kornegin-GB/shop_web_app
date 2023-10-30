import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shop_web_app/database_helper/database_update_list.dart';
import 'package:shop_web_app/models/cart_product_model.dart';
import 'package:shop_web_app/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseApp {
  final String _databaseName = 'favourite_database.db';
  final int _databaseVersion = 2;
  final String _columnProductId = 'productId';
  final String _tableFavourite = 'favourites';
  final String _tableSoppingCart = 'shoppingCart';

  String get columnProductId => _columnProductId;

  String get tableFavourite => _tableFavourite;

  String get tableSoppingCart => _tableSoppingCart;

  static final DatabaseApp db = DatabaseApp._();

  DatabaseApp._();

  // ignore: prefer_typing_uninitialized_variables
  var _database;

  Future get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }
  }

  ///Создание базы данных
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (Database db, int version) async {
        for (int ver = 0; ver <= version; ver++) {
          DatabaseUpdateList().dbOperationsVersion(db, ver);
        }
      },
      onUpgrade: (db, int oldVersion, int newVersion) {
        for (int version = oldVersion; version <= newVersion; version++) {
          DatabaseUpdateList().dbOperationsVersion(db, version);
        }
      },
      onOpen: (db) {},
    );
  }

  ///Внесение записи в базу данных
  insertProduct(var item, String tableName) async {
    final db = await database;
    return await db.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateProduct(var item, String tableName) async {
    final db = await database;
    return await db.update(
      tableName,
      item.toMap(),
      where: '$_columnProductId = ?',
      whereArgs: [item.productId],
    );
  }

  ///Чтение всех записей избранного из базы данных
  getAllFavourites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableFavourite);
    return List.generate(maps.length, (i) {
      return ProductModel.fromJson(maps[i]);
    });
  }

  ///Чтение всех записей корзины из базы данных
  getAllCartProduct() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableSoppingCart);
    return List.generate(maps.length, (i) {
      return CartProductModel.fromJson(maps[i]);
    });
  }

  ///Проверяем есть ли запись в базе данных
  productExists(int id) async {
    final db = await database;
    var result = await db.query(
      tableFavourite,
      where: '$_columnProductId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty; //Если запись есть то true
  }

  ///Проверяем пуста ли таблица
  // isEmptyTable() async {
  //   final db = await database;
  //   var result = await db.query(tableSoppingCart);
  //   return result.isEmpty; // если пусто true
  // }

  ///Удаление записи из базы данных
  deleteProduct(int id, String tableName) async {
    final db = await database;
    await db.delete(
      tableName,
      where: '$_columnProductId = ?',
      whereArgs: [id],
    );
  }

  ///Очистка таблицы
  clearCartProduct() async {
    final db = await database;
    await db.delete(_tableSoppingCart);
  }

  ///Закрытие соединения с базой данных
// closeDB() async {
//   final db = await database;
//   db.close();
// }
}
