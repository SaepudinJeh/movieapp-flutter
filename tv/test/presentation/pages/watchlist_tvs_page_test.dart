import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistTvsBloc extends MockBloc<WatchlistTvsEvent, WatchlistTvsState> implements WatchlistTvsBloc {}

class WatchlistTvsEventFake extends Fake implements WatchlistTvsEvent {}

class WatchlistTvsStateFake extends Fake implements WatchlistTvsState {}

@GenerateMocks([WatchlistTvsBloc])
void main() {
  late MockWatchlistTvsBloc mockWatchlistTvsBloc;

  setUp(() {
    mockWatchlistTvsBloc = MockWatchlistTvsBloc();
  });

  setUpAll(() {
    registerFallbackValue(WatchlistTvsEventFake());
    registerFallbackValue(WatchlistTvsStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvsBloc>.value(
      value: mockWatchlistTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockWatchlistTvsBloc.state).thenReturn(WatchlistTvsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockWatchlistTvsBloc.state).thenReturn(WatchlistTvsHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockWatchlistTvsBloc.state).thenReturn(WatchlistTvsError('error_message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
