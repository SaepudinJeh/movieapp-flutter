import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late TopRatedTvsBloc res;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    res = TopRatedTvsBloc(mockGetTopRatedTvs);
  });

  test('initial state should be empty', () {
    expect(res.state, TopRatedTvsEmpty());
  });

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
    'Should emit [TopRatedTvsLoading, TopRatedTvsHasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvs.execute()).thenAnswer((_) async => Right(testTvList));
      return res;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    expect: () => [
      TopRatedTvsLoading(),
      TopRatedTvsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
    'Should emit [TopRatedTvsLoading, TopRatedTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvs.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return res;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    expect: () => [
      TopRatedTvsLoading(),
      TopRatedTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );
}
