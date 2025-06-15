part of 'movie_category_cubit.dart';

sealed class MovieCategoryState {
  const MovieCategoryState();
}

final class MovieCategoryInitialState implements MovieCategoryState {
  const MovieCategoryInitialState();
}

final class MovieCategoryLoadingState implements MovieCategoryState {
  const MovieCategoryLoadingState();
}

final class MovieCategorySuccessState extends Equatable implements MovieCategoryState {

  const MovieCategorySuccessState(this.movies);

  final List<MovieInfoEntity> movies;

  @override
  List<Object?> get props => [movies];
}

final class MovieCategoryFailureState extends Equatable implements MovieCategoryState {
  const MovieCategoryFailureState(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}
