import 'package:http/testing.dart';
import 'package:udemy_flutter_news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';

void main() {
  test('FetchTopIds returns a list of Top story ids', () async {
    // Setup of test case
    final newsApiProvider = NewsApiProvider();
    newsApiProvider.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApiProvider.fetchTopIds();
    // Expectation
    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns an ItemModel', () async {
    final newsApiProvider = NewsApiProvider();
    newsApiProvider.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final itemModel = await newsApiProvider.fetchItem(999);
    // Expectation
    expect(itemModel?.id, 123);
  });
}
