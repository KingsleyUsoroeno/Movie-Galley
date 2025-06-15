import 'package:domain/movie/entity/movie_entity.dart';
import 'package:domain/movie/repository/movie_repository.dart';
import 'package:domain/utils/maybe_result.dart';

class FetchMovieCategoriesUseCase {
  final MovieRepository movieRepository;

  FetchMovieCategoriesUseCase({required this.movieRepository});

  Future<MaybeResult<MovieCategoryEntity>> call() => movieRepository.fetchMovieCategories();
}
