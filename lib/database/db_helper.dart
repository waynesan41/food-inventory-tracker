import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'package:food_inventory_tracker/model/food_item.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    print("@@@@ DATABASE HELPER @@@@@@");
    print(dbPath);
    final String myDBPath = join(dbPath, "foodInventory.db");
    print(myDBPath);

    return await sql.openDatabase(
      myDBPath,
      version: 1,
      onCreate: createDB,
    );
  }

//Create Table Query
  static Future createDB(sql.Database db, int version) async {
    print("###############CREATING DATA BASE FOR FIRST TIME ################");
    final tableName = "food_item";
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final intTypeNull = "INTEGER NULL";
    final textTypeNull = "TEXT NULL";
    final boolType = "BOOLEAN NOT NULL DEFAULT FALSE";

    await db.execute('''
      CREATE TABLE $tableName (
        ${FoodItemFields.id} $idType,
        ${FoodItemFields.name} $textTypeNull,
        ${FoodItemFields.description} $textTypeNull,
        ${FoodItemFields.imgUrl} $textTypeNull,
        ${FoodItemFields.addedDate} $intTypeNull,
        ${FoodItemFields.expireDate} $intTypeNull,
        ${FoodItemFields.hidden} $boolType,
        ${FoodItemFields.deleted} $boolType
      )
    ''');
    setInitialData();
  }
  // Getting All Food Data

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT * FROM 'food_item'");
  }

  //=========================================
  // Adding New Item to Database
  //=========================================
  static Future<int> addData(FoodItem newData) async {
    print("AAAAAAAAAAAAAAAAAAAAADDDDDDDDDDD:");
    final db = await DBHelper.database();

    final String updateQuery = '''
    INSERT INTO food_item( 
    ${FoodItemFields.name},
    ${FoodItemFields.description},
    ${FoodItemFields.imgUrl},
    ${FoodItemFields.addedDate},
    ${FoodItemFields.expireDate}
    ) VALUES(?, ?, ?, ?, ?)
  ''';
    return await db.rawInsert(updateQuery, [
      newData.name,
      newData.description,
      newData.imgUrl,
      newData.addedDate.millisecondsSinceEpoch,
      newData.expireDate == null
          ? null
          : newData.expireDate!.millisecondsSinceEpoch,
    ]);
  }

  //=========================================
  //UPDATING Database Editing SQFlite Database
  //=========================================
  static Future<int> updateData(int id, FoodItem updateData) async {
    print("UUUUUUUUUUUUUUUUUUUUPPPPPPPPPPPP:$id");
    final db = await DBHelper.database();

    final String updateQuery = '''
    UPDATE food_item SET 
    ${FoodItemFields.name} = ?,
    ${FoodItemFields.description} = ?,
    ${FoodItemFields.imgUrl} = ?,
    ${FoodItemFields.addedDate} = ?,
    ${FoodItemFields.expireDate} = ?,
    ${FoodItemFields.hidden} = ?,
    ${FoodItemFields.deleted} = ?
    WHERE id = ?
  ''';
    return await db.rawUpdate(updateQuery, [
      updateData.name,
      updateData.description,
      updateData.imgUrl,
      updateData.addedDate.millisecondsSinceEpoch,
      updateData.expireDate == null
          ? null
          : updateData.expireDate!.millisecondsSinceEpoch,
      updateData.hidden ? 1 : 0,
      updateData.deleted ? 1 : 0,
      id
    ]);
  }

  // Initializing Fake Data =====================================================

  static Future<void> setInitialData() async {
    print("=============== Innitial Value Set =====================");

    final myDB = await DBHelper.database();
    int id1 = await myDB.rawInsert('''
        INSERT INTO food_item(
          ${FoodItemFields.name}, 
          ${FoodItemFields.description}, 
          ${FoodItemFields.imgUrl}, 
          ${FoodItemFields.addedDate}, 
          ${FoodItemFields.expireDate},
          ${FoodItemFields.hidden},
          ${FoodItemFields.deleted}
        )
        VALUES(
          "Europian Organic Farm Raise Chicken",
          "Rosted Chicken",
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/chicken.jpg",
          ${DateTime.parse("2023-01-21 20:13:04Z").millisecondsSinceEpoch},
          ${DateTime.parse("2023-04-21 20:13:04Z").millisecondsSinceEpoch},
          0,
          0
        ),(
          "Mango",
          "Sweet Mango",
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/mango.jpg",
          ${DateTime.parse("2023-02-17 11:40:04Z").millisecondsSinceEpoch},
          ${DateTime.parse("2023-04-21 20:13:04Z").millisecondsSinceEpoch},
          0,
          0
        ),(
          "Orange",
          "Sweet Jusy Orange",
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/orange.jpg",
          ${DateTime.parse("2023-02-15 00:00:00Z").millisecondsSinceEpoch},
          ${DateTime.parse("2023-03-15 00:00:00Z").millisecondsSinceEpoch},
          0,
          0
        ),(
          null,
          "Medium Sweet Chicken Hart Fry",
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/chickenheart.jpg",
          ${DateTime.parse("2023-01-21 20:13:04Z").millisecondsSinceEpoch},
          null,
          0,
          0
        ),(
          "Tuna Fish",
          "Fresh Full Tuna Fish",
          null,
          ${DateTime.parse("2023-01-21 20:13:04Z").millisecondsSinceEpoch},
          null,
          0,
          0
        ),(
          "Ramen Noddle",
          "Frozen Raman Noodle true flavor",
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/ramen.jpg",
          ${DateTime.parse("2021-01-21 20:13:04Z").millisecondsSinceEpoch},
          ${DateTime.parse("2023-04-21 20:13:04Z").millisecondsSinceEpoch},
          0,
          0
        ),(
          "Onion",
          "Medium Sweet Onion",
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/onion.jpg",
          ${DateTime.parse("2022-11-21 21:13:04Z").millisecondsSinceEpoch},
          null,
          0,
          0
        ),(
          null,
          null,
          null,
          ${DateTime.parse("2023-01-12 05:13:04Z").millisecondsSinceEpoch},
          null,
          0,
          0
        )
        ''');
    print("Inserted $id1");
  } // End Of Initial Data function
} //End DBHelper() class





