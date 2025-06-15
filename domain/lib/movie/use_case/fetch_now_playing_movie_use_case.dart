import 'package:domain/domain_dependencies.dart';
import 'package:domain/utils/maybe_result.dart';

class FetchNowPlayingMovieUseCase {
  final MovieRepository movieRepository;

  FetchNowPlayingMovieUseCase({required this.movieRepository});

  Future<MaybeResult<NowPlayingMovieEntity>> call(int page) {
    return movieRepository.fetchNowPlayingMovies(page: page);
  }
}
