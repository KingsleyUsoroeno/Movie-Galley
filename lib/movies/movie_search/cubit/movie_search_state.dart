part of 'movie_search_cubit.dart';

sealed class MovieSearchState {
  const MovieSearchState();
}

final class MovieSearchInitialState extends MovieSearchState {
  const MovieSearchInitialState();
}

final class MovieSearchLoadingState implements MovieSearchState {
  const MovieSearchLoadingState();
}

final class MovieSearchSuccessState extends Equatable implements MovieSearchState {
  const MovieSearchSuccessState(this.movies);

  final List<MovieInfoEntity> movies;

  @override
  List<Object?> get props => [movies];
}

final class MovieSearchFailureState extends Equatable implements MovieSearchState {
  const MovieSearchFailureState(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}