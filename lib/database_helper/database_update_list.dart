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

  final String _columnUserId = 'userId';
  final String _columnUserName = 'userName';
  final String _columnUserPassword = 'userPassword';

  dbOperationsVersion(Database db, int version) async {
    switch (version) {
      case 1:
        await _dbChangesV1(db);
        break;
      case 2:
        await _dbChangesV2(db);
        break;
      case 3:
        await _dbChangesV3(db);
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

  ///Обновление базы данных v3
  _dbChangesV3(Database db) async {
    await db.execute('''
          CREATE TABLE ${mainDb.tableUsers}
          (
            $_columnUserId INTEGER PRIMARY KEY,
            $_columnUserName VARCHAR(100),
            ${mainDb.columnUserEmail} VARCHAR(100) NOT NULL,
            $_columnUserPassword VARCHAR(100) NOT NULL
          )
    ''');
    await db.execute('''
          ALTER TABLE ${mainDb.tableFavourite} RENAME TO ${mainDb.tableFavourite}_old;
    ''');
    await db.execute('''
          CREATE TABLE ${mainDb.tableFavourite}
          (
            $_columnId INTEGER PRIMARY KEY,
            ${mainDb.columnProductId} INTEGER,
            $_columnDescriptionProduct TEXT,
            $_columnNameProduct VARCHAR(100) NOT NULL,
            $_columnImgProduct VARCHAR(100) NOT NULL,
            $_columnPriceProduct INTEGER NOT NULL            
          )
    ''');
    await db.execute('''
          ALTER TABLE ${mainDb.tableFavourite}
          ADD COLUMN ${mainDb.columnFkUserId} INTEGER
          REFERENCES ${mainDb.tableUsers} ($_columnUserId)
    ''');
    await db.execute('''
          ALTER TABLE ${mainDb.tableSoppingCart}
          ADD COLUMN ${mainDb.columnFkUserId} INTEGER
          REFERENCES ${mainDb.tableUsers} ($_columnUserId)
    ''');
    await db.execute('''
          DROP TABLE IF EXISTS ${mainDb.tableFavourite}_old
    ''');
  }
}
