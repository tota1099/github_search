import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/external/datasources/github_datasource.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}
main() {

  final dio = DioMock();
  final datasource = GitHubDatasource(dio);
  
  test("Should return a list of ResultSearchModel", () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final future = datasource.getSearch("searchText");
    expect(future, completes);
  });
}