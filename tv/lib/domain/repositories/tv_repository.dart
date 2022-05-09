import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTvs(String query);
  Future<Either<Failure, String>> saveWatchlistTvs(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlistTvs(TvDetail tv);
  Future<bool> isAddedToWatchlistTvs(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTvs();
}
