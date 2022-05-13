part of 'watchlist_tvs_bloc.dart';

@immutable
abstract class WatchlistTvsEvent extends Equatable {
  const WatchlistTvsEvent();

  @override
  List<Object?> get props => [];
}

class FetchWatchlistTvs extends WatchlistTvsEvent {}

class AddWatchListTv extends WatchlistTvsEvent {
  final TvDetail tvDetail;

  const AddWatchListTv(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class RemoveFromWatchListTv extends WatchlistTvsEvent {
  final TvDetail tvDetail;

  const RemoveFromWatchListTv(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class LoadWatchlistStatusTv extends WatchlistTvsEvent {
  final int id;

  const LoadWatchlistStatusTv(this.id);

  @override
  List<Object?> get props => [id];
}
