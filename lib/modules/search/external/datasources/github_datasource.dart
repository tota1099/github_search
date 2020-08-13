import 'package:dio/dio.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/infra/datasources/search_datasource.dart';
import 'package:github_search/modules/search/infra/models/result_search_model.dart';

extension on String {
  normalize() {
    return this.replaceAll(" ", "+");
  }
}

class GitHubDatasource implements SearchDataSource {
  final Dio dio;

  GitHubDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio.get("https://api.github.com/search/users?q=${searchText.normalize()}");
    
    if(response.statusCode == 200) {
      var jsonList = response.data['items'] as List;
      final list = jsonList
          .map((item) => ResultSearchModel(
              nickname: item['login'],
              image: item['avatar_url'],
              url: item['url']))
          .toList();
      return list;
    } else {
      throw DatasourceError();
    }
  }

}