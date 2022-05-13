import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTvsBloc popularTvsBloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    popularTvsBloc = PopularTvsBloc(mockGetPopularTvs);
  });

  test('initial state should be empty', () {
    expect(popularTvsBloc.state, PopularTvsEmpty());
  });

  blocTest<PopularTvsBloc, PopularTvsState>(
    'Should emit [PopularTvsLoading, PopularTvsHasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(testTvList));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    expect: () => [
      PopularTvsLoading(),
      PopularTvsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );

  blocTest<PopularTvsBloc, PopularTvsState>(
    'Should emit [PopularTvsLoading, PopularTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    expect: () => [
      PopularTvsLoading(),
      PopularTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );
}
