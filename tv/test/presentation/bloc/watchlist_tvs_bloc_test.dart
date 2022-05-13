import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv, SaveWatchlistTv, RemoveWatchlistTv, GetWatchListStatusTv])
void main() {
  late WatchlistTvsBloc watchlistTvsBloc;
  late MockGetWatchlistTv mockGetWatchlistTvs;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;
  late MockGetWatchListStatusTv mockGetWatchListStatus;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTv();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    mockGetWatchListStatus = MockGetWatchListStatusTv();
    watchlistTvsBloc = WatchlistTvsBloc(
      mockGetWatchlistTvs,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchListStatus,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistTvsBloc.state, WatchlistTvsEmpty());
  });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
    'Should emit [WatchlistTvsLoading, WatchlistTvsHasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvs.execute()).thenAnswer((_) async => Right(testTvList));
      return watchlistTvsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvs()),
    expect: () => [
      WatchlistTvsLoading(),
      WatchlistTvsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
    'Should emit [WatchlistTvsLoading, WatchlistTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvs.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvs()),
    expect: () => [
      WatchlistTvsLoading(),
      WatchlistTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );
}
