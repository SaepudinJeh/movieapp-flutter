part of 'search_tvs_bloc.dart';

@immutable
abstract class SearchTvsState extends Equatable {
  const SearchTvsState();

  @override
  List<Object?> get props => [];
}

class SearchTvsEmpty extends SearchTvsState {}

class SearchTvsLoading extends SearchTvsState {}

class SearchTvsHasData extends SearchTvsState {
  final List<Tv> result;

  const SearchTvsHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class SearchTvsError extends SearchTvsState {
  final String message;

  const SearchTvsError(this.message);

  @override
  List<Object?> get props => [message];
}
