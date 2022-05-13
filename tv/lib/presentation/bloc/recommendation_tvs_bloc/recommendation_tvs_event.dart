part of 'recommendation_tvs_bloc.dart';

@immutable
abstract class RecommendationTvsEvent extends Equatable {
  const RecommendationTvsEvent();

  @override
  List<Object?> get props => [];
}

class FetchRecommendationTvs extends RecommendationTvsEvent {
  final int id;

  const FetchRecommendationTvs(this.id);

  @override
  List<Object?> get props => [id];
}
