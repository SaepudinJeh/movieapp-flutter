import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getMovieDetail;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  final GetWatchListStatus _getWatchListStatus;

  DetailMovieBloc(this._getMovieDetail, this._saveWatchlist, this._removeWatchlist, this._getWatchListStatus)
      : super(DetailMovieEmpty()) {
    on<FetchDetailMovie>((event, emit) async {
      final id = event.id;

      emit(DetailMovieLoading());
      final result = await _getMovieDetail.execute(id);

      result.fold(
        (failure) {
          emit(DetailMovieError(failure.message));
        },
        (data) {
          emit(DetailMovieHasData(data));
        },
      );
    });

    on<AddWatchListMovie>(
      (event, emit) async {
        final movieDetail = event.movieDetail;
        final result = await _saveWatchlist.execute(movieDetail);

        result.fold(
          (failure) {
            emit(WatchlistMessageFailure(failure.message));
          },
          (successMessage) {
            emit(WatchlistMessageSuccess(successMessage));
          },
        );
        add(LoadWatchlistStatus(movieDetail.id));
      },
    );

    on<RemoveFromWatchListMovie>(
      (event, emit) async {
        final movieDetail = event.movieDetail;
        final result = await _removeWatchlist.execute(movieDetail);

        result.fold(
          (failure) {
            emit(WatchlistMessageFailure(failure.message));
          },
          (successMessage) {
            emit(WatchlistMessageSuccess(successMessage));
          },
        );
        add(LoadWatchlistStatus(movieDetail.id));
      },
    );

    on<LoadWatchlistStatus>(
      (event, emit) async {
        final id = event.id;
        final result = await _getWatchListStatus.execute(id);

        emit(WatchlistStatus(result));
      },
    );
  }
}
