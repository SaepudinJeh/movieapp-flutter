part of 'recommendation_tvs_bloc.dart';

@immutable
abstract class RecommendationTvsState extends Equatable {
  const RecommendationTvsState();

  @override
  List<Object?> get props => [];
}

class RecommendationTvsEmpty extends RecommendationTvsState {}

class RecommendationTvsLoading extends RecommendationTvsState {}

class RecommendationTvsHasData extends RecommendationTvsState {
  final List<Tv> result;

  const RecommendationTvsHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class RecommendationTvsError extends RecommendationTvsState {
  final String message;

  const RecommendationTvsError(this.message);

  @override
  List<Object?> get props => [message];
}
