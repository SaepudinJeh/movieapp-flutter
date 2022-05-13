part of 'on_the_air_tvs_bloc.dart';

@immutable
abstract class OnTheAirTvsEvent extends Equatable {
  const OnTheAirTvsEvent();

  @override
  List<Object?> get props => [];
}

class FetchOnTheAirTvs extends OnTheAirTvsEvent {}
