part of 'popular_movies_cubit.dart';

sealed class PopularMoviesState {
  const PopularMoviesState();
}

final class PopularMoviesInitialState implements PopularMoviesState {}

final class PopularMoviesLoadingState implements PopularMoviesState {}

final class PopularMoviesSuccessState extends Equatable implements PopularMoviesState {
  final List<MovieInfoEntity> movies;

  const PopularMoviesSuccessState(this.movies);

  @override
  List<Object?> get props => [movies];
}

final class PopularMoviesFailureState extends Equatable implements PopularMoviesState {
  final String message;

  const PopularMoviesFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
