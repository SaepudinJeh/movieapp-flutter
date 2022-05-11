part of 'detail_movies_bloc.dart';

@immutable
abstract class DetailMoviesEvent extends Equatable {
  const DetailMoviesEvent();

  @override
  List<Object?> get props => [];
}

class FetchDetailMovies extends DetailMoviesEvent {
  final int id;

  const FetchDetailMovies(this.id);

  @override
  List<Object?> get props => [id];
}
