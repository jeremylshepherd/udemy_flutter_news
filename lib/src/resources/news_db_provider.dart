import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import '../models/item_model.dart';

class NewsDbProvider {
  late Database db;

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute('''
      CREATE TABLE Items
      (
        id INTEGER PRIMARY KEY,
        deleted INTEGER,
        type TEXT,
        by TEXT,
        time TEXT,
        text TEXT,
        dead INTEGER
        parent INTEGER,
        kids BLOB,
        url TEXT,
        score INTEGER,
        title TEXTS,
        descendants INTEGER
      )
      ''');
    });
  }

  fetchItem(int id) async {
    final maps = await db.query(
      'Items',
      columns: null,
      where: 'id = ',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  addItem(ItemModel item) {
    return db.insert('Items', item.toMapForDb());
  }
}
