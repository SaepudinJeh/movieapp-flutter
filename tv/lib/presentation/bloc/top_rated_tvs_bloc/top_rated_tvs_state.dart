part of 'top_rated_tvs_bloc.dart';

@immutable
abstract class TopRatedTvsState extends Equatable {
  const TopRatedTvsState();

  @override
  List<Object?> get props => [];
}

class TopRatedTvsEmpty extends TopRatedTvsState {}

class TopRatedTvsLoading extends TopRatedTvsState {}

class TopRatedTvsHasData extends TopRatedTvsState {
  final List<Tv> result;

  const TopRatedTvsHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TopRatedTvsError extends TopRatedTvsState {
  final String message;

  const TopRatedTvsError(this.message);

  @override
  List<Object?> get props => [message];
}
