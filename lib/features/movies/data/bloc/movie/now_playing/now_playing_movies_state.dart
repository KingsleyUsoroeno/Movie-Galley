import 'package:equatable/equatable.dart';
import 'package:movies/features/movies/data/local/model/database/model/now_playing_movies_model.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class InitialNowPlayingMoviesState extends NowPlayingMoviesState {}

class NowPlayingMovieEmpty extends NowPlayingMoviesState {}

class NowPlayingMovieLoading extends NowPlayingMoviesState {}

class NowPlayingMovieLoaded extends NowPlayingMoviesState {
  final NowPlayingMoviesDatabaseModel nowPlayingMovies;

  NowPlayingMovieLoaded({this.nowPlayingMovies});

  @override
  List<Object> get props => [nowPlayingMovies];
}

class NowPlayingMovieLoadMore extends NowPlayingMoviesState {
  final List<Results> movies;

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
