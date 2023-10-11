import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesDb extends ChangeNotifier {
  final String _databaseName = 'favourite_database.db';
  final int _databaseVersion = 1;
  final String table = 'favorites';
  final String columnId = 'id';
  final String columnNameProduct = 'nameProduct';
  final String columnDescriptionProduct = 'descriptionProduct';
  final String columnImgProduct = 'imgProduct';
  final String columnPriceProduct = 'priceProduct';

  static final FavoritesDb db = FavoritesDb._();

  FavoritesDb._();

  ///Создание базы данных
  initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $table
          (
            $columnId INTEGER PRIMARY KEY,
            $columnDescriptionProduct TEXT,
            $columnNameProduct VARCHAR(100) NOT NULL,
            $columnImgProduct VARCHAR(100) NOT NULL,
            $columnPriceProduct INTEGER NOT NULL
          )
          ''');
    });
  }

  ///Внесение записи в базу данных
  insertProduct(Product product) async {
    final db = await initDatabase();
    notifyListeners();
    return await db.insert(
      table,
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///Чтение всех записей из базы данных
  showAllProducts() async {
    final db = await initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i][columnId],
        nameProduct: maps[i][columnNameProduct],
        descriptionProduct: maps[i][columnDescriptionProduct],
        priceProduct: maps[i][columnPriceProduct],
        imgProduct: maps[i][columnImgProduct],
      );
    });
  }

  ///Проверяем есть ли запись в базе данных
  isFavourite(int id) async {
    final db = await initDatabase();
    var result = await db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? true : false;
  }

  ///Удаление записи из базы данных
  deleteProduct(int id) async {
    final db = await initDatabase();
    await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  ///Закрытие соединения с базой данных
  closeDB() async {
    final db = await initDatabase();
    db.close();
  }
}
