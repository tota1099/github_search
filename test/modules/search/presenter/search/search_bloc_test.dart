import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search/presenter/search/search_bloc.dart';
import 'package:github_search/presenter/search/states/state.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText {}
main() {

  final usecase = SearchByTextMock();
  final bloc =  SearchBloc(usecase);

  test("Should return the states in the correct order", () {
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]) );
    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchSuccess>()
    ]));
    bloc.add("renan");
  });

  test("Should return a error if input is invalid", () {
    when(usecase.call(any)).thenAnswer((_) async => Left(InvalidTextError()) );
    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchError>()
    ]));
    bloc.add("renan");
  });
}