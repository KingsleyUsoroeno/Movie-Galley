import 'package:domain/imports/module_imports.dart';
import 'package:domain/model/movie_result.dart';
import 'package:equatable/equatable.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class InitialNowPlayingMoviesState extends NowPlayingMoviesState {}

class NowPlayingMovieLoading extends NowPlayingMoviesState {}

class NowPlayingMovieLoaded extends NowPlayingMoviesState {
  final Movie nowPlayingMovies;

  NowPlayingMovieLoaded({this.nowPlayingMovies});

  @override
  List<Object> get props => [nowPlayingMovies];
}

class NowPlayingMovieLoadMore extends NowPlayingMoviesState {
  final List<MovieResult> movies;

  NowPlayingMovieLoadMore({this.movies});

  @override
  List<Object> get props => [movies];
}

class NowPlayingMovieError extends NowPlayingMoviesState {
  final String errorMessage;

  NowPlayingMovieError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
