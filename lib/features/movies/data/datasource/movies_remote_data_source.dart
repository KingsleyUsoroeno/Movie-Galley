import 'package:meta/meta.dart';
import 'package:movies/features/movies/data/remote/model/movies.dart';
import 'package:movies/features/movies/data/remote/model/now_playing.dart';
import 'package:movies/features/movies/data/remote/model/popular_movie.dart';
import 'package:movies/features/movies/data/service/movie_api_service.dart';

abstract class MoviesRemoteDataSource {
  Future<Movies> getMovieCategories();

  Future<NowPlayingResponse> getNowPlayingMovies({bool loadMore = false});

  Future<PopularMovie> getPopularMovies({bool loadMore = false});

  Future<Movies> searchForMovie(String query, {bool loadMore = false});
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final MovieApiService movieApiService;

  MoviesRemoteDataSourceImpl({@required this.movieApiService});

  @override
  Future<Movies> getMovieCategories() {
    return movieApiService.getMovieCategories();
  }

  @override
  Future<NowPlayingResponse> getNowPlayingMovies({bool loadMore = false}) {
    return movieApiService.getNowPlayingMovies(loadMore: loadMore);
  }

  @override
  Future<PopularMovie> getPopularMovies({bool loadMore = false}) {
    return movieApiService.getPopularMovies(loadMore: loadMore);
  }

  @override
  Future<Movies> searchForMovie(String query, {bool loadMore = false}) {
    return movieApiService.searchForMovie(query, loadMore: loadMore);
  }
}
