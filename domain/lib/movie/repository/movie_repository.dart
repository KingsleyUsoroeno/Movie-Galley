import 'package:domain/movie/entity/movie_entity.dart';
import 'package:domain/movie/entity/movie_info_entity.dart';
import 'package:domain/utils/maybe_result.dart';


abstract interface class MovieRepository {
  Future<MaybeResult<MovieCategoryEntity>> fetchMovieCategories();

  Future<MaybeResult<PopularMovieEntity>> fetchPopularMovies({int page = 1});

  Future<MaybeResult<NowPlayingMovieEntity>> fetchNowPlayingMovies({int page = 1});

  Future<MaybeResult<List<MovieInfoEntity>>> searchMovie(int page, String query);
}
