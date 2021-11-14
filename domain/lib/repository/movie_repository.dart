import 'package:dartz/dartz.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/model/movie.dart';

/// Either is provided by the Dartz Package and supports functional programming in
/// Dart and as seen below it will always either return a Failure object on the Left or a
/// response of our Model object on the right*/
abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getAllMovieCategories();

  Future<Either<Failure, List<Movie>>> getAllPopularMovies({
    bool loadMore = false,
  });

  Future<Either<Failure, List<Movie>>> getAllNowPlayingMovies({
    bool loadMore = false,
    int page,
  });

  Future<Either<Failure, Movie>> searchMovie(
    int page,
    String query, {
    bool loadMore = false,
  });
}
