import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMoviesBloc(this._getWatchlistMovies) : super(WatchlistMoviesEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
        (data) {
          emit(WatchlistMoviesHasData(data));
        },
      );
    });
  }
}
