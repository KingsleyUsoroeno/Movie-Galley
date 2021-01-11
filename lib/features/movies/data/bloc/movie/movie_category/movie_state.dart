import 'package:equatable/equatable.dart';
import 'package:movies/features/movies/data/local/database/model/movie_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class InitialMovieState extends MovieState {}

class MovieEmpty extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final MovieDatabaseModel movie;

  MovieLoaded({this.movie});

  @override
  List<Object> get props => [movie];
}

class MovieError extends MovieState {
  final String errorMessage;

  MovieError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
