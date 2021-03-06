import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/infra/datasources/search_datasource.dart';
import 'package:github_search/modules/search/infra/models/result_search_model.dart';
import 'package:github_search/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:mockito/mockito.dart';

class SearchDataSourceMock extends Mock implements SearchDataSource {}

main() {
  final datasource = SearchDataSourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('Should return a list of ResultSearch', () async {
    when(datasource.getSearch(any)).thenAnswer((_) async => <ResultSearchModel>[]);
    final result = await repository.search("renan");
    
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Should return DatasourceError if datasource throws', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());
    final result = await repository.search("renan");
    
    expect(result.fold(id, id), isA<DatasourceError>());
  });
}