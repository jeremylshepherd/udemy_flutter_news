import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:udemy_flutter_news/src/resources/cache.dart';
import 'package:udemy_flutter_news/src/resources/source.dart';
import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
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

  @override
  Future<List<int>> fetchTopIds() {
    print('bs implementation');
    return Future.value([1, 2, 3]);
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
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

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert('Items', item.toMapForDb());
  }
}

final newsDbProvider = NewsDbProvider();
