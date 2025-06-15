import 'package:domain/domain_dependencies.dart';

abstract interface class MovieRemoteDatasource {
  Future<MovieCategoryEntity> fetchMovieCategories();

  Future<PopularMovieEntity> fetchPopularMovies({int page = 1});

  Future<NowPlayingMovieEntity> fetchNowPlayingMovies({int page = 1});

  Future<List<MovieInfoEntity>> searchForMovie(String query, int page);
}
