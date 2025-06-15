part of 'now_playing_movies_cubit.dart';

sealed class NowPlayingMoviesState {
  const NowPlayingMoviesState();
}

final class NowPlayingMoviesInitialState extends NowPlayingMoviesState {
  const NowPlayingMoviesInitialState();
}

final class NowPlayingMoviesLoadingState implements NowPlayingMoviesState {
  const NowPlayingMoviesLoadingState();
}

final class NowPlayingMoviesSuccessState extends Equatable implements NowPlayingMoviesState {
  const NowPlayingMoviesSuccessState(this.movies);

  final List<MovieInfoEntity> movies;

  @override
  List<Object?> get props => [movies];
}

final class NowPlayingMoviesFailureState extends Equatable implements NowPlayingMoviesState {
  const NowPlayingMoviesFailureState(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}
