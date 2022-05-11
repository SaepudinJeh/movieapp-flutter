part of 'detail_movie_bloc.dart';

@immutable
abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object?> get props => [];
}

class DetailMovieEmpty extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieHasData extends DetailMovieState {
  final MovieDetail result;

  const DetailMovieHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class DetailMovieError extends DetailMovieState {
  final String message;

  const DetailMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistMessageSuccess extends DetailMovieState {
  final String message;

  const WatchlistMessageSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMessageFailure extends DetailMovieState {
  final String message;

  const WatchlistMessageFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistStatus extends DetailMovieState {
  final bool isAddedToWatchlist;

  const WatchlistStatus(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
