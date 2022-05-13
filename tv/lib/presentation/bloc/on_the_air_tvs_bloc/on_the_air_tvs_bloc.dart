import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'on_the_air_tvs_event.dart';
part 'on_the_air_tvs_state.dart';

class OnTheAirTvsBloc extends Bloc<OnTheAirTvsEvent, OnTheAirTvsState> {
  final GetOnTheAirTvs _getOnTheAirTvs;

  OnTheAirTvsBloc(this._getOnTheAirTvs) : super(OnTheAirTvsEmpty()) {
    on<FetchOnTheAirTvs>((event, emit) async {
      emit(OnTheAirTvsLoading());
      final result = await _getOnTheAirTvs.execute();

      result.fold(
        (failure) {
          emit(OnTheAirTvsError(failure.message));
        },
        (data) {
          emit(OnTheAirTvsHasData(data));
        },
      );
    });
  }
}
