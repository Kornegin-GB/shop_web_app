import 'package:flutter/cupertino.dart';
import 'package:shop_web_app/database_app.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseUpdateList {
  var mainDb = DatabaseApp.db;

  final String _tableSoppingCart = 'shoppingCart';
  final String _columnQuantityProduct = 'quantityProduct';

  dbOperationsVersion(Database db, int version) async {
    switch (version) {
      case 1:
        await _dbChangesV1(db);
        break;
      case 2:
        await _dbChangesV2(db);
        break;
    }
  }

  ///Базы данных v1
  _dbChangesV1(Database db) async {
    debugPrint("БД версия 1 загружена");
    await db.execute('''
          CREATE TABLE ${mainDb.tableFavourite}
          (
            ${mainDb.columnId} INTEGER PRIMARY KEY,
            ${mainDb.columnDescriptionProduct} TEXT,
            ${mainDb.columnNameProduct} VARCHAR(100) NOT NULL,
            ${mainDb.columnImgProduct} VARCHAR(100) NOT NULL,
            ${mainDb.columnPriceProduct} INTEGER NOT NULL
          )
          ''');
  }

  ///Обновление базы данных v2
  _dbChangesV2(Database db) async {
    debugPrint("БД версия 2 загружена");
    // await db.execute('ALTER TABLE ${mainDb.tableFavourite} ADD COLUMN '
    //     '$_columnQuantityProduct '
    //     'INTEGER NOT NULL DEFAULT 0');
    // await db.execute('''
    //       CREATE TABLE $_tableSoppingCart
    //       (
    //         ${mainDb.columnId} INTEGER PRIMARY KEY,
    //         ${mainDb.columnDescriptionProduct} TEXT,
    //         ${mainDb.columnNameProduct} VARCHAR(100) NOT NULL,
    //         ${mainDb.columnImgProduct} VARCHAR(100) NOT NULL,
    //         ${mainDb.columnPriceProduct} INTEGER NOT NULL,
    //         $_columnQuantityProduct INTEGER NOT NULL
    //       )
    //       ''');
  }
}
