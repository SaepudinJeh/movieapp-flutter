import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tvs_event.dart';
part 'watchlist_tvs_state.dart';

class WatchlistTvsBloc extends Bloc<WatchlistTvsEvent, WatchlistTvsState> {
  final GetWatchlistTv _getWatchlistTv;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;
  final GetWatchListStatusTv _getWatchListStatusTv;

  WatchlistTvsBloc(this._getWatchlistTv, this._saveWatchlistTv, this._removeWatchlistTv, this._getWatchListStatusTv)
      : super(WatchlistTvsEmpty()) {
    on<FetchWatchlistTvs>((event, emit) async {
      emit(WatchlistTvsLoading());
      final result = await _getWatchlistTv.execute();

      result.fold(
        (failure) {
          emit(WatchlistTvsError(failure.message));
        },
        (data) {
          emit(WatchlistTvsHasData(data));
        },
      );
    });

    on<AddWatchListTv>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await _saveWatchlistTv.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvsMessageFailure(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvsMessageSuccess('Added To Watchlist'));
        },
      );
      add(LoadWatchlistStatusTv(tvDetail.id));
    });

    on<RemoveFromWatchListTv>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await _removeWatchlistTv.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvsMessageFailure(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvsMessageSuccess('Removed From Watchlist'));
        },
      );
      add(LoadWatchlistStatusTv(tvDetail.id));
    });

    on<LoadWatchlistStatusTv>((event, emit) async {
      final id = event.id;
      final result = await _getWatchListStatusTv.execute(id);

      emit(WatchlistTvsStatus(result));
    });
  }
}
