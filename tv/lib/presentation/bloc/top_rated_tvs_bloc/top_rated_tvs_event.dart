part of 'top_rated_tvs_bloc.dart';

@immutable
abstract class TopRatedTvsEvent extends Equatable {
  const TopRatedTvsEvent();

  @override
  List<Object?> get props => [];
}

class FetchTopRatedTvs extends TopRatedTvsEvent {}
