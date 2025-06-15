import 'package:domain/domain_dependencies.dart';
import 'package:domain/utils/maybe_result.dart';

typedef SearchMovieParam = ({String query, int page});

class SearchMovieUseCase {
  final MovieRepository movieRepository;

  SearchMovieUseCase({required this.movieRepository});

  Future<MaybeResult<List<MovieInfoEntity>>> call(SearchMovieParam param) async {
    return await movieRepository.searchMovie(param.page, param.query);
  }
}
