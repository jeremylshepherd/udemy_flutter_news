import 'dart:async';
import 'package:udemy_flutter_news/src/resources/source.dart';

import 'cache.dart';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    ItemModel? fetched;
    Source source;

    for (source in sources) {
      fetched = await source.fetchItem(id);
      if (fetched != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (fetched != null) {
        cache.addItem(fetched);
      }
    }

    item = fetched!;
    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}
