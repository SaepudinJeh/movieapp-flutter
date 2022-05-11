part of 'detail_movies_bloc.dart';

@immutable
abstract class DetailMoviesState extends Equatable {
  const DetailMoviesState();

  @override
  List<Object?> get props => [];
}

class DetailMoviesEmpty extends DetailMoviesState {}

class DetailMoviesLoading extends DetailMoviesState {}

class DetailMoviesHasData extends DetailMoviesState {
  final MovieDetail result;

  const DetailMoviesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class DetailMoviesError extends DetailMoviesState {
  final String message;

  const DetailMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
