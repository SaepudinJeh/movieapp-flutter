part of 'watchlist_tvs_bloc.dart';

@immutable
abstract class WatchlistTvsState extends Equatable {
  const WatchlistTvsState();

  @override
  List<Object?> get props => [];
}

class WatchlistTvsEmpty extends WatchlistTvsState {}

class WatchlistTvsLoading extends WatchlistTvsState {}

class WatchlistTvsHasData extends WatchlistTvsState {
  final List<Tv> result;

  const WatchlistTvsHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchlistTvsError extends WatchlistTvsState {
  final String message;

  const WatchlistTvsError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistTvsMessageSuccess extends WatchlistTvsState {
  final String message;

  const WatchlistTvsMessageSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvsMessageFailure extends WatchlistTvsState {
  final String message;

  const WatchlistTvsMessageFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvsStatus extends WatchlistTvsState {
  final bool isAddedToWatchlist;

  const WatchlistTvsStatus(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
