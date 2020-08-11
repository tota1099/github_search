import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';

abstract class SearchByText {
  Either<Exception, Future<List<ResultSearch>>> call(String searchText);
}