import 'dart:async';
import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'package:hacker_news/src/resources/news_db_provider.dart';
import 'package:hacker_news/src/models/item_model.dart';

class Repository {
  // NewsApiProvider apiProvider = NewsApiProvider();
  // NewsDbProvider dbProvider = NewsDbProvider();
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
    var source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (caches != source) {
        cache.addItem(item);
      }
    }

    return item;
    // var item = await dbProvider.fetchItem(id);

    // if (item != null) {
    //   return item;
    // }

    // item = await apiProvider.fetchItem(id);
    // dbProvider.addItem(item);

    // return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
