import 'package:domain/domain_dependencies.dart';
import 'package:domain/utils/maybe_result.dart';

class FetchPopularMoviesUseCase {
  final MovieRepository movieRepository;

  FetchPopularMoviesUseCase({required this.movieRepository});

  Future<MaybeResult<PopularMovieEntity>> call(int page) {
    return movieRepository.fetchPopularMovies(page: page);
  }
}
