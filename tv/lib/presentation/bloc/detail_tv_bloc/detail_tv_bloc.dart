import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvDetail _getTvDetail;

  DetailTvBloc(this._getTvDetail) : super(DetailTvEmpty()) {
    on<FetchDetailTv>((event, emit) async {
      final id = event.id;

      emit(DetailTvLoading());
      final result = await _getTvDetail.execute(id);

      result.fold(
        (failure) {
          emit(DetailTvError(failure.message));
        },
        (data) {
          emit(DetailTvHasData(data));
        },
      );
    });
  }
}
