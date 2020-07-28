import 'package:equatable/equatable.dart';
import 'package:movies/features/movies/data/remote/model/movies.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchEmpty extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final Movies movies;

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
