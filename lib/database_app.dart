import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/database_update_list.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseApp {
  final String _databaseName = 'favourite_database.db';
  final int _databaseVersion = 1;
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

  Future get database async{
    if(_database != null){
      return _database;
    }else{
      _database = await initDatabase();
      return _database;
    }
  }

  ///Создание базы данных
  Future<Database> initDatabase() async {
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

  ///Чтение всех записей избранного из базы данных
  showAllFavourites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableFavourite);
    return List.generate(maps.length, (i) {
      return Product.fromJson(maps[i]);
    });
  }

  ///Чтение всех записей корзины из базы данных
  showAllProductsShoppingCart() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableSoppingCart);
    return List.generate(maps.length, (i) {
      return ShoppingCart.fromJson(maps[i]);
    });
  }

  ///Проверяем есть ли запись в базе данных
  isNotEmptyProduct(int id) async {
    final db = await database;
    var result = await db.query(
      tableFavourite,
      where: '$_columnProductId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty; //Если запись есть то true
  }

  ///Проверяем пуста ли таблица
  isEmptyTable() async {
    final db = await database;
    var result = await db.query(tableSoppingCart);
    return result.isEmpty; // если пусто true
  }

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
  deleteTable(String tableName) async {
    final db = await database;
    await db.delete(tableName);
  }

  ///Закрытие соединения с базой данных
// closeDB() async {
//   final db = await database;
//   db.close();
// }
}
