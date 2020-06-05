import 'package:equatable/equatable.dart';
import 'package:movies/data/remote/model/now_playing.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class InitialNowPlayingMoviesState extends NowPlayingMoviesState {}

class NowPlayingMovieEmpty extends NowPlayingMoviesState {}

class NowPlayingMovieLoading extends NowPlayingMoviesState {}

class NowPlayingMovieLoaded extends NowPlayingMoviesState {
  final NowPlayingResponse movie;

  NowPlayingMovieLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class NowPlayingMovieError extends NowPlayingMoviesState {
  final String errorMessage;

  NowPlayingMovieError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
