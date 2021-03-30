import 'package:domain/model/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchEmpty extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final Movie movies;

  MovieSearchLoaded({this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieSearchError extends MovieSearchState {
  final String errorMessage;

  MovieSearchError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
