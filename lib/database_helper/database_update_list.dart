import 'package:shop_web_app/database_helper/database_app.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseUpdateList {
  var mainDb = DatabaseApp.db;

  final String _columnNameProduct = 'nameProduct';
  final String _columnDescriptionProduct = 'descriptionProduct';
  final String _columnImgProduct = 'imgProduct';
  final String _columnPriceProduct = 'priceProduct';
  final String _columnQuantityProduct = 'quantityProduct';
  final String _columnId = 'id';

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
    await db.execute('''
          CREATE TABLE ${mainDb.tableFavourite}
          (
            ${mainDb.columnProductId} INTEGER PRIMARY KEY,
            $_columnDescriptionProduct TEXT,
            $_columnNameProduct VARCHAR(100) NOT NULL,
            $_columnImgProduct VARCHAR(100) NOT NULL,
            $_columnPriceProduct INTEGER NOT NULL
          )
          ''');
  }

  ///Обновление базы данных v2
  _dbChangesV2(Database db) async {
    await db.execute('''
          CREATE TABLE ${mainDb.tableSoppingCart}
          (
            $_columnId INTEGER PRIMARY KEY,
            ${mainDb.columnProductId} INTEGER,
            $_columnNameProduct VARCHAR(100) NOT NULL,
            $_columnImgProduct VARCHAR(100) NOT NULL,
            $_columnPriceProduct INTEGER NOT NULL,
            $_columnQuantityProduct INTEGER NOT NULL
          )
          ''');
  }
}
