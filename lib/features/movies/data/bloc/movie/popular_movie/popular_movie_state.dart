import 'package:equatable/equatable.dart';
import 'package:movies/features/movies/data/local/database/model/popular_movie_model.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class InitialPopularMovieState extends PopularMovieState {}

class PopularMovieEmpty extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  final PopularMoviesDatabaseModel popularMovie;

  PopularMovieLoaded({this.popularMovie});

  @override
  List<Object> get props => [popularMovie];
}

class PopularMovieError extends PopularMovieState {
  final String errorMessage;

  PopularMovieError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
