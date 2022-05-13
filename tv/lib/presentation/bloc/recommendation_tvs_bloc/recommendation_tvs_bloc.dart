import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tvs_event.dart';
part 'recommendation_tvs_state.dart';

class RecommendationTvsBloc extends Bloc<RecommendationTvsEvent, RecommendationTvsState> {
  final GetTvRecommendations _getTvRecommendations;

  RecommendationTvsBloc(this._getTvRecommendations) : super(RecommendationTvsEmpty()) {
    on<FetchRecommendationTvs>((event, emit) async {
      final id = event.id;

      emit(RecommendationTvsLoading());
      final result = await _getTvRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(RecommendationTvsError(failure.message));
        },
        (data) {
          emit(RecommendationTvsHasData(data));
        },
      );
    });
  }
}
