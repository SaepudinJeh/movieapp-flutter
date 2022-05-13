import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_air_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvs])
void main() {
  late OnTheAirTvsBloc onTheAirTvsBloc;
  late MockGetOnTheAirTvs mockGetOnTheAirTvs;

  setUp(() {
    mockGetOnTheAirTvs = MockGetOnTheAirTvs();
    onTheAirTvsBloc = OnTheAirTvsBloc(mockGetOnTheAirTvs);
  });

  test('initial state should be empty', () {
    expect(onTheAirTvsBloc.state, OnTheAirTvsEmpty());
  });

  blocTest<OnTheAirTvsBloc, OnTheAirTvsState>(
    'Should emit [OnTheAirTvsLoading, OnTheAirTvsHasData] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTvs.execute()).thenAnswer((_) async => Right(testTvList));
      return onTheAirTvsBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvs()),
    expect: () => [
      OnTheAirTvsLoading(),
      OnTheAirTvsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTvs.execute());
    },
  );

  blocTest<OnTheAirTvsBloc, OnTheAirTvsState>(
    'Should emit [OnTheAirTvsLoading, OnTheAirTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetOnTheAirTvs.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return onTheAirTvsBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvs()),
    expect: () => [
      OnTheAirTvsLoading(),
      OnTheAirTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTvs.execute());
    },
  );
}
