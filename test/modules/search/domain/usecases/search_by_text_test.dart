import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';

main() {

  final usecase = SearchByTextImpl();
  
  test('Should return a list of ResultSearch', () async {
    final result = await usecase("renan");
    expect(result, isA<Right>());
    expect(result | null, isA<List<ResultSearch>>());
  });
}