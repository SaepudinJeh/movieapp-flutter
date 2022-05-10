import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/search_tvs_bloc/search_tvs_bloc.dart';
import 'package:tv/tv.dart';
import 'package:dartz/dartz.dart';

import 'search_tvs_bloc_test.mocks.dart';

final tTvModel = Tv(
  backdropPath: '/path.jpg',
  genreIds: const [1],
  id: 1,
  name: 'name',
  originalLanguage: 'en',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  voteAverage: 1.0,
  voteCount: 1,
);

final tTvList = <Tv>[tTvModel];
const tQuery = 'Moon Knight';

@GenerateMocks([SearchTvs])
void main() {
  late SearchTvsBloc searchTvsBloc;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    searchTvsBloc = SearchTvsBloc(mockSearchTvs);
  });

  test('initial state should be empty', () {
    expect(searchTvsBloc.state, SearchTvsEmpty());
  });

  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tQuery)).thenAnswer((_) async => Right(tTvList));
      return searchTvsBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvsLoading(),
      SearchTvsHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );

  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvs.execute(tQuery)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvsBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvsLoading(),
      SearchTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );
}
