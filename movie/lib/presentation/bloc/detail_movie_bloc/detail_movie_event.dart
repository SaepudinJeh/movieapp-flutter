part of 'detail_movie_bloc.dart';

@immutable
abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchDetailMovie extends DetailMovieEvent {
  final int id;

  const FetchDetailMovie(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchListMovie extends DetailMovieEvent {
  final MovieDetail movieDetail;

  const AddWatchListMovie(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class RemoveFromWatchListMovie extends DetailMovieEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchListMovie(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class LoadWatchlistStatus extends DetailMovieEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}
