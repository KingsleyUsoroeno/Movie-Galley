import 'package:data/model/movie_entity.dart';
import 'package:data/model/now_playing_movie_entity.dart';
import 'package:data/model/popular_movie_entity.dart';

abstract class MovieRemote {
  Future<MovieEntity> fetchAllMovieCategories();

  Future<PopularMovieEntity> fetchPopularMovies(
      {int page, bool loadMore = false});

  Future<NowPlayingMovieEntity> fetchAllNowPlayingMovies(
      {int page, bool loadMore = false});

  Future<MovieEntity> searchForMovie(String query, int page,
      {bool loadMore = false});
}
