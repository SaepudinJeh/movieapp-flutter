import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late DetailTvBloc detailTvBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    detailTvBloc = DetailTvBloc(mockGetTvDetail);
  });

  const int id = 1;

  test('initial state should be empty', () {
    expect(detailTvBloc.state, DetailTvEmpty());
  });

  blocTest<DetailTvBloc, DetailTvState>(
    'Should emit [DetailTvLoading, DetailTvHasData] when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(id)).thenAnswer((_) async => Right(testTvDetail));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(FetchDetailTv(id)),
    expect: () => [
      DetailTvLoading(),
      DetailTvHasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
    },
  );

  blocTest<DetailTvBloc, DetailTvState>(
    'Should emit [DetailTvLoading, DetailTvError] when get data is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(id)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(FetchDetailTv(id)),
    expect: () => [
      DetailTvLoading(),
      DetailTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
    },
  );
}
