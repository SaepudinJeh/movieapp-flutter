import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'detail_movies_event.dart';
part 'detail_movies_state.dart';

class DetailMoviesBloc extends Bloc<DetailMoviesEvent, DetailMoviesState> {
  final GetMovieDetail _getMovieDetail;

  DetailMoviesBloc(this._getMovieDetail) : super(DetailMoviesEmpty()) {
    on<FetchDetailMovies>((event, emit) async {
      final id = event.id;

      emit(DetailMoviesLoading());
      final result = await _getMovieDetail.execute(id);

      result.fold(
        (failure) {
          emit(DetailMoviesError(failure.message));
        },
        (data) {
          emit(DetailMoviesHasData(data));
        },
      );
    });
  }
}
