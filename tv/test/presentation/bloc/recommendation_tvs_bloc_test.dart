import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late RecommendationTvsBloc recommendationTvsBloc;
  late MockGetTvRecommendations mockGetRecommendationTvs;

  setUp(() {
    mockGetRecommendationTvs = MockGetTvRecommendations();
    recommendationTvsBloc = RecommendationTvsBloc(mockGetRecommendationTvs);
  });

  const id = 1;

  test('initial state should be empty', () {
    expect(recommendationTvsBloc.state, RecommendationTvsEmpty());
  });

  blocTest<RecommendationTvsBloc, RecommendationTvsState>(
    'Should emit [RecommendationTvsLoading, RecommendationTvsHasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationTvs.execute(id)).thenAnswer((_) async => Right(testTvList));
      return recommendationTvsBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationTvs(id)),
    expect: () => [
      RecommendationTvsLoading(),
      RecommendationTvsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvs.execute(id));
    },
  );

  blocTest<RecommendationTvsBloc, RecommendationTvsState>(
    'Should emit [RecommendationTvsLoading, RecommendationTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetRecommendationTvs.execute(id)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationTvsBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationTvs(id)),
    expect: () => [
      RecommendationTvsLoading(),
      RecommendationTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvs.execute(id));
    },
  );
}
