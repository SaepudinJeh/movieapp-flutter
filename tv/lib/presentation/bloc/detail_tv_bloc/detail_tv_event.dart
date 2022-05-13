part of 'detail_tv_bloc.dart';

@immutable
abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();

  @override
  List<Object?> get props => [];
}

class FetchDetailTv extends DetailTvEvent {
  final int id;

  const FetchDetailTv(this.id);

  @override
  List<Object?> get props => [id];
}
