import 'package:movies/features/movies/data/remote/model/movies.dart';
import 'package:movies/features/movies/data/remote/model/now_playing.dart';
import 'package:movies/features/movies/data/remote/model/popular_movie.dart';

abstract class MovieApiService {
  Future<Movies> getMovieCategories();

  Future<NowPlayingResponse> getNowPlayingMovies({bool loadMore = false});

  Future<PopularMovie> getPopularMovies({bool loadMore = false});

  Future<Movies> searchForMovie(String query, {bool loadMore = false});
}
