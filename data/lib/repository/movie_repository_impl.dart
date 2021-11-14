import 'package:dartz/dartz.dart';
import 'package:data/contract/cache/movie_cache.dart';
import 'package:data/contract/remote/movie_remote.dart';
import 'package:data/mapper/movie_mapper.dart';
import 'package:data/model/movie_entity.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/model/movie.dart';
import 'package:domain/repository/movie_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemote movieRemote;
  final MovieCache movieCache;
  final MovieMapper movieMapper;

  MovieRepositoryImpl({
    @required this.movieRemote,
    @required this.movieCache,
    @required this.movieMapper,
  });

  @override
  Future<Either<Failure, List<Movie>>> getAllMovieCategories() async {
    try {
      final movie = await movieRemote.fetchMovieCategories();
      await movieCache.saveMovie(movie);

      final cachedMovies =
          movieMapper.mapFromEntityList(await movieCache.getCachedMovies());

      return Right(cachedMovies);
    } catch (e) {
      final movies = await retrieveCachedMovieCategories();
      if (movies != null || movies.isNotEmpty) return Right(movies);
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getAllNowPlayingMovies({
    bool loadMore = false,
    int page = 1,
  }) async {
    try {
      if (loadMore) {
        final movies = await loadMoreNowPlayingMovies();
        return Right(movieMapper.mapFromEntityList(movies));
      }

      final movies = await getNowPlayingMovies(page);
      await movieCache.saveNowPlaying(movies);
      final savedMovie = await movieCache.getCachedNowPlaying();
      return Right(movieMapper.mapFromEntityList(savedMovie));
    } catch (e) {
      final movies = await retrieveCachedNowPlayingMovies();
      if (movies != null || movies.isNotEmpty) return Right(movies);
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getAllPopularMovies(
      {bool loadMore = false}) async {
    try {
      final movie = await movieRemote.fetchPopularMovies();
      await movieCache.savePopularMovies(movie);
      final savedMovie = await movieCache.getCachedPopularMovies();
      return Right(movieMapper.mapFromEntityList(savedMovie));
    } catch (e) {
      final movies = await retrieveCachedPopularMovies();
      if (movies != null || movies.isNotEmpty) return Right(movies);
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Movie>> searchMovie(
    int page,
    String query, {
    bool loadMore = false,
  }) async {
    try {
      final searchedMovie = await movieRemote.searchForMovie(query, page);
      if (searchedMovie != null || searchedMovie.results.isNotEmpty) {
        return Right(movieMapper.mapFromEntity(searchedMovie));
      } else
        return Left(
            ServerFailure(errorMessage: "Movie with that name not found"));
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  Future<MovieEntity> getNowPlayingMovies(int page) {
    return movieRemote.fetchNowPlayingMovies(page: page);
  }

  Future<List<MovieEntity>> loadMoreNowPlayingMovies() async {
    final savedMovies = await movieCache.getCachedNowPlaying();
    final cachedNowPlaying = savedMovies.first;

    int currentPage = cachedNowPlaying.page;

    final newMovie = cachedNowPlaying.copyWith(page: currentPage += 1);

    final movieResponse = await getNowPlayingMovies(newMovie.page);

    newMovie.results.addAll(movieResponse.results);

    await movieCache.updateNowPlaying(newMovie);

    return movieCache.getCachedNowPlaying();
  }

  Future<List<Movie>> retrieveCachedMovieCategories() async {
    final movies = await movieCache.getCachedMovies();
    return movieMapper.mapFromEntityList(movies);
  }

  Future<List<Movie>> retrieveCachedPopularMovies() async {
    final movies = await movieCache.getCachedPopularMovies();
    return movieMapper.mapFromEntityList(movies);
  }

  Future<List<Movie>> retrieveCachedNowPlayingMovies() async {
    final movies = await movieCache.getCachedNowPlaying();
    return movieMapper.mapFromEntityList(movies);
  }
}
