import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularTvsBloc extends MockBloc<PopularTvsEvent, PopularTvsState> implements PopularTvsBloc {}

class PopularTvsEventFake extends Fake implements PopularTvsEvent {}

class PopularTvsStateFake extends Fake implements PopularTvsState {}

@GenerateMocks([PopularTvsBloc])
void main() {
  late MockPopularTvsBloc mockPopularTvsBloc;

  setUp(() {
    mockPopularTvsBloc = MockPopularTvsBloc();
  });

  setUpAll(() {
    registerFallbackValue(PopularTvsEventFake());
    registerFallbackValue(PopularTvsStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvsBloc>.value(
      value: mockPopularTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockPopularTvsBloc.state).thenReturn(PopularTvsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockPopularTvsBloc.state).thenReturn(PopularTvsHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockPopularTvsBloc.state).thenReturn(PopularTvsError('error_message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
