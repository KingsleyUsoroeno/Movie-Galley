import 'package:equatable/equatable.dart';
import 'package:movies/features/movies/data/local/database/model/movie_model.dart';

abstract class MovieBlocState extends Equatable {
  const MovieBlocState();

  @override
  List<Object> get props => [];
}

class InitialMovieBlocState extends MovieBlocState {}

class MovieEmpty extends MovieBlocState {}

class MovieLoading extends MovieBlocState {}

class MovieLoaded extends MovieBlocState {
  final MovieDatabaseModel movie;

  MovieLoaded({this.movie});

  @override
  List<Object> get props => [movie];
}

class MovieError extends MovieBlocState {
  final String errorMessage;

  MovieError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
