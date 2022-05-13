import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTvsBloc extends MockBloc<TopRatedTvsEvent, TopRatedTvsState> implements TopRatedTvsBloc {}

class TopRatedTvsEventFake extends Fake implements TopRatedTvsEvent {}

class TopRatedTvsStateFake extends Fake implements TopRatedTvsState {}

@GenerateMocks([TopRatedTvsBloc])
void main() {
  late MockTopRatedTvsBloc mockTopRatedTvsBloc;

  setUp(() {
    mockTopRatedTvsBloc = MockTopRatedTvsBloc();
  });

  setUpAll(() {
    registerFallbackValue(TopRatedTvsEventFake());
    registerFallbackValue(TopRatedTvsStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvsBloc>.value(
      value: mockTopRatedTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockTopRatedTvsBloc.state).thenReturn(TopRatedTvsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockTopRatedTvsBloc.state).thenReturn(TopRatedTvsHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockTopRatedTvsBloc.state).thenReturn(TopRatedTvsError('error_message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
