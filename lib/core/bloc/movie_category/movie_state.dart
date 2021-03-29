import 'package:domain/model/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class InitialMovieState extends MovieState {}

class MovieEmpty extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final Movie movie;

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
