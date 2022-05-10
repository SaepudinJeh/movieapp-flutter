import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/tv.dart';

part 'search_tvs_event.dart';
part 'search_tvs_state.dart';

class SearchTvsBloc extends Bloc<SearchTvsEvent, SearchTvsState> {
  final SearchTvs _searchTvs;

  SearchTvsBloc(this._searchTvs) : super(SearchTvsEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvsLoading());
      final result = await _searchTvs.execute(query);

      result.fold(
        (failure) {
          emit(SearchTvsError(failure.message));
        },
        (data) {
          emit(SearchTvsHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
