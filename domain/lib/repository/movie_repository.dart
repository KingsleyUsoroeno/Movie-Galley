import 'package:dartz/dartz.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/model/movie.dart';
import 'package:domain/model/now_playing_movie.dart';
import 'package:domain/model/popular_movie.dart';

/// Either is provided by the Dartz Package and supports functional programming in
/// Dart and as seen below it will always either return a Failure object on the Left or a
/// response of our Model object on the right*/
abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getAllMovieCategories();

  Future<Either<Failure, List<PopularMovie>>> getAllPopularMovies(
      {bool loadMore = false});

  Future<Either<Failure, List<NowPlayingMovie>>> getAllNowPlayingMovies(
      {bool loadMore = false});

  Future<Either<Failure, Movie>> searchMovie(String query,
      {bool loadMore = false});
}
