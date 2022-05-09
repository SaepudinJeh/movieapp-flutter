import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tv/tv.dart';
import 'package:core/core.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../../../core/test/json_reader.dart';

void main() {
  const apiKey = 'api_key=e0dc2d1cb4d4d2e18be89b6258a3e458';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get On The Air TV', () {
    final tTvList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv/on_the_air.json'))).tvList;

    test('should return list of Tv Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnTheAirTv();
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular TV', () {
    final tTvList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv/popular.json'))).tvList;

    test('should return list of Tv Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/popular.json'), 200));
      // act
      final result = await dataSource.getPopularTv();
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated TV', () {
    final tTvList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv/top_rated.json'))).tvList;

    test('should return list of Tv Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTv();
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Detail', () {
    const tId = 1;
    final tTvDetail = TvDetailModel.fromJson(json.decode(readJson('dummy_data/tv/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search Tv Series', () {
    const tvQuery = 'Moon Knight';
    final tTvList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv/search_moon_knight_tv.json'))).tvList;

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tvQuery')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/search_moon_knight_tv.json'), 200));
      // act
      final result = await dataSource.searchTvs(tvQuery);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tvQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvs(tvQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Recommendations', () {
    const tId = 1;
    final tTvList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv/tv_recommendations.json'))).tvList;

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvRecommendations(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
