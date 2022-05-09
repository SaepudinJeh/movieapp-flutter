import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchMoviesEmpty()) {
    on<OnQueryChanged>(((event, emit) async {
      final query = event.query;

      emit(SearchMoviesLoading());
      final result = await _searchMovies.execute(query);

      result.fold((failure) {
        emit(SearchMoviesError(failure.message));
      }, (data) {
        emit(SearchMoviesHasData(data));
      });
    }));
  }
}
