import 'package:rxdart/rxdart.dart';
import 'package:udemy_flutter_news/src/models/item_model.dart';
import 'package:udemy_flutter_news/src/resources/news_api_provider.dart';
import 'package:udemy_flutter_news/src/resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _apiProvider = NewsApiProvider();

  Stream<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    print('bloc fetchTopIds called');
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
  }
}
