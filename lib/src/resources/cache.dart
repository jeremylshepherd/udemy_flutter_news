import 'package:udemy_flutter_news/src/models/item_model.dart';

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
