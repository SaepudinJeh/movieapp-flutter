import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  TvRemoteDataSource,
  MovieLocalDataSource,
  TvLocalDataSource,
  DatabaseMovieHelper,
  DatabaseTvHelper
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
