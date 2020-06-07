import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/movies/data/local/model/database/model/movie_model.dart';
import 'package:movies/features/movies/data/local/model/database/model/now_playing_movies_model.dart';
import 'package:movies/features/movies/data/local/model/database/model/popular_movie_model.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';

/// Either is provided by the Dartz Package and supports functional programming in
/// Dart and as seen below it will always either return a Failure object on the Left or a
/// response of our Model object on the right*/
abstract class MoviesRepository {
  Future<Either<Failure, MovieDatabaseModel>> fetchAllMovieCategories();

  Future<Either<Failure, PopularMoviesDatabaseModel>> fetchAllPopularMovies({bool loadMore = false});

  Future<Either<Failure, NowPlayingMoviesDatabaseModel>> fetchAllNowPlayingMovies({bool loadMore = false});

  Future<Either<Failure, List<Results>>> fetchMoreNowPlayingMovies({bool loadMore = false});
}
