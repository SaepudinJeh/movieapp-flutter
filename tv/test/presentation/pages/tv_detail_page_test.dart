import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailTvBloc extends MockBloc<DetailTvEvent, DetailTvState> implements DetailTvBloc {}

class DetailTvEventFake extends Fake implements DetailTvEvent {}

class DetailTvStateFake extends Fake implements DetailTvState {}

class MockRecommendationTvsBloc extends MockBloc<RecommendationTvsEvent, RecommendationTvsState>
    implements RecommendationTvsBloc {}

class RecommendationTvsEventFake extends Fake implements RecommendationTvsEvent {}

class RecommendationTvsStateFake extends Fake implements RecommendationTvsState {}

class MockWatchlistTvsBloc extends MockBloc<WatchlistTvsEvent, WatchlistTvsState> implements WatchlistTvsBloc {}

class WatchlistTvsEventFake extends Fake implements WatchlistTvsEvent {}

class WatchlistTvsStateFake extends Fake implements WatchlistTvsState {}

@GenerateMocks([DetailTvBloc])
void main() {
  late MockDetailTvBloc mockDetailTvBloc;
  late MockRecommendationTvsBloc mockRecommendationTvsBloc;
  late MockWatchlistTvsBloc mockWatchlistTvsBloc;

  setUpAll(() {
    registerFallbackValue(DetailTvEventFake());
    registerFallbackValue(DetailTvStateFake());
    registerFallbackValue(RecommendationTvsEventFake());
    registerFallbackValue(RecommendationTvsStateFake());
    registerFallbackValue(WatchlistTvsEventFake());
    registerFallbackValue(WatchlistTvsStateFake());
  });

  setUp(() {
    mockDetailTvBloc = MockDetailTvBloc();
    mockRecommendationTvsBloc = MockRecommendationTvsBloc();
    mockWatchlistTvsBloc = MockWatchlistTvsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvBloc>(create: (context) => mockDetailTvBloc),
        BlocProvider<RecommendationTvsBloc>(create: (context) => mockRecommendationTvsBloc),
        BlocProvider<WatchlistTvsBloc>(create: (context) => mockWatchlistTvsBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Watchlist button should display add icon when tv not added to watchlist', (WidgetTester tester) async {
    when(() => mockDetailTvBloc.state).thenReturn(DetailTvHasData(testTvDetail));
    when(() => mockRecommendationTvsBloc.state).thenReturn(RecommendationTvsHasData(testTvList));
    when(() => mockWatchlistTvsBloc.state).thenReturn(WatchlistTvsStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should dispay check icon when tv is added to wathclist', (WidgetTester tester) async {
    when(() => mockDetailTvBloc.state).thenReturn(DetailTvHasData(testTvDetail));
    when(() => mockRecommendationTvsBloc.state).thenReturn(RecommendationTvsHasData(testTvList));
    when(() => mockWatchlistTvsBloc.state).thenReturn(WatchlistTvsStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
