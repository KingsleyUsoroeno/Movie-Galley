import 'package:equatable/equatable.dart';
import 'package:movies/data/remote/model/movies.dart';
import 'package:movies/data/remote/model/now_playing.dart';
import 'package:movies/data/remote/model/popular_movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MoviesEmpty extends MovieState {}

class MoviesLoading extends MovieState {}

class MoviesCategoryLoaded extends MovieState {
  final Movies movies;

  MoviesCategoryLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class PopularMoviesLoaded extends MovieState {
  final PopularMovie popularMovie;

  PopularMoviesLoaded(this.popularMovie);

  @override
  List<Object> get props => [popularMovie];
}

class NowPlayingMoviesLoaded extends MovieState {
  final NowPlayingResponse nowPlayingMovies;

  NowPlayingMoviesLoaded(this.nowPlayingMovies);

  @override
  List<Object> get props => [nowPlayingMovies];
}

class MoviesError extends MovieState {
  final String errorMessage;

  MoviesError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
