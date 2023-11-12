import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shop_web_app/database_helper/database_update_list.dart';
import 'package:shop_web_app/models/cart_product_model.dart';
import 'package:shop_web_app/models/product_model.dart';
import 'package:shop_web_app/models/user_authorization_model.dart';
import 'package:shop_web_app/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseApp {
  final String _databaseName = 'favourite_database.db';
  final int _databaseVersion = 3;
  final String _columnProductId = 'productId';
  final String _tableFavourite = 'favourites';
  final String _tableSoppingCart = 'shoppingCart';
  final String _tableUsers = 'users';
  final String _columnUserEmail = 'userEmail';
  final String _columnFkUserId = 'FK_userId';

  String get columnProductId => _columnProductId;

  String get columnUserEmail => _columnUserEmail;

  String get columnFkUserId => _columnFkUserId;

  String get tableFavourite => _tableFavourite;

  String get tableSoppingCart => _tableSoppingCart;

  String get tableUsers => _tableUsers;

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

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  ///Инициализация и создание базы данных
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      path,
      version: _databaseVersion,
      onConfigure: _onConfigure,
      onCreate: (Database db, int version) async {
        for (int ver = 0; ver <= version; ver++) {
          DatabaseUpdateList().dbOperationsVersion(db, ver);
        }
      },
      onUpgrade: (db, int oldVersion, int newVersion) async {
        for (int version = oldVersion; version <= newVersion; version++) {
          DatabaseUpdateList().dbOperationsVersion(db, version);
        }
      },
      onOpen: (db) {},
    );
  }

  ///Внесение продукта в [item] (корзины или избранного) в таблицу [tableName]
  ///базы данных
  insertProduct(var item, String tableName) async {
    final db = await database;
    return await db.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///Обновление продукта [item] (корзины или избранного) в таблице [tableName]
  ///базы данных
  updateProduct(var item, String tableName) async {
    final db = await database;
    return await db.update(
      tableName,
      item.toMap(),
      where: '$_columnProductId = ? AND $_columnFkUserId = ?',
      whereArgs: [item.productId, item.fkUserId],
    );
  }

  ///Чтение записей избранного из базы данных
  getFavouritesList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableFavourite,
      where: '$_columnFkUserId = ?',
      whereArgs: [UserAuthorizationModel().currentUser?.userId],
    );
    return List.generate(maps.length, (i) {
      return ProductModel.fromJson(maps[i]);
    });
  }

  ///Чтение всех записей корзины из базы данных
  getCartProductCurrentUser(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableSoppingCart,
      where: '$_columnFkUserId = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) {
      return CartProductModel.fromJson(maps[i]);
    });
  }

  ///Проверяем есть ли продукт в избранном в базе данных по [id]
  ///
  /// Метод возвращает `true` если запись существует
  productExists(int id, int currentUserId) async {
    final db = await database;
    var result = await db.query(
      tableFavourite,
      where: '$_columnProductId = ? AND $_columnFkUserId = ?',
      whereArgs: [id, currentUserId],
    );
    return result.isNotEmpty;
  }

  ///Удаление записи из таблицы [tableName] базы данных по [id]
  deleteProduct(int id, int userId, String tableName) async {
    final db = await database;
    await db.delete(
      tableName,
      where: '$_columnProductId = ? AND $_columnFkUserId = ?',
      whereArgs: [id, userId],
    );
  }

  ///Очистка корзины продуктов в базе данных
  clearCartProduct(int userId) async {
    final db = await database;
    await db.delete(_tableSoppingCart,
        where: '$_columnFkUserId = ?', whereArgs: [userId]);
  }

  ///Метод добавления нового пользователя [user]
  insertUser(UserModel user) async {
    final db = await database;
    await db.insert(
      _tableUsers,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///Проверяем есть ли пользователь в базе данных по [email]
  ///
  /// Метод возвращает `true` если запись существует
  Future<bool> userExists(String email) async {
    final db = await database;
    var result = await db.query(
      _tableUsers,
      where: '$_columnUserEmail = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  ///Проверяем введённый пароль пользователя с сохранённым при регистрации
  Future<bool> authorizationUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      _tableUsers,
      where: '$_columnUserEmail = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      var users = result.map((e) => UserModel.fromJson(e)).toList();
      return users[0].userPassword == password;
    }
    return false;
  }

  ///Получаем данные текущего пользователя
  Future<UserModel> getUser(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      _tableUsers,
      where: '$_columnUserEmail = ?',
      whereArgs: [email],
    );
    var users = result.map((e) => UserModel.fromJson(e)).toList();
    return users[0];
  }
}
