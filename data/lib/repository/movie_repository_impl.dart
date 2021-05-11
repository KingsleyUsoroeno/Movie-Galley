import 'package:dartz/dartz.dart';
import 'package:data/contract/cache/movie_cache.dart';
import 'package:data/contract/remote/movie_remote.dart';
import 'package:data/mapper/movie_mapper.dart';
import 'package:data/mapper/now_playing_movie_mapper.dart';
import 'package:data/mapper/popular_movie_mapper.dart';
import 'package:data/model/now_playing_movie_entity.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/model/movie.dart';
import 'package:domain/model/now_playing_movie.dart';
import 'package:domain/model/popular_movie.dart';
import 'package:domain/repository/movie_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemote movieRemote;
  final MovieCache movieCache;
  final MovieMapper movieMapper;
  final NowPlayingMovieMapper nowPlayingMovieMapper;
  final PopularMovieEntityMapper popularMovieEntityMapper;

  MovieRepositoryImpl({
    @required this.movieRemote,
    @required this.movieCache,
    @required this.movieMapper,
    @required this.nowPlayingMovieMapper,
    @required this.popularMovieEntityMapper,
  });

  @override
  Future<Either<Failure, List<Movie>>> getAllMovieCategories() async {
    try {
      final cacheMovie = await movieCache.getAllMovies();
      if (cacheMovie != null && cacheMovie.isNotEmpty) {
        return Right(movieMapper.mapFromEntityList(cacheMovie));
      } else {
        final movie = await movieRemote.fetchAllMovieCategories();
        await movieCache.saveMovie(movie);
        final savedMovie = await movieCache.getAllMovies();
        return Right(movieMapper.mapFromEntityList(savedMovie));
      }
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NowPlayingMovie>>> getAllNowPlayingMovies({
    bool loadMore = false,
    int page = 1,
  }) async {
    try {
      if (loadMore) {
        final movies = await loadMoreNowPlayingMovies();
        return Right(nowPlayingMovieMapper.mapFromEntityList(movies));
      }

      final cachedMovie = await movieCache.getAllNowPlaying();
      if (cachedMovie != null && cachedMovie.isNotEmpty) {
        return Right(nowPlayingMovieMapper.mapFromEntityList(cachedMovie));
      } else {
        final movie = await getNowPlayingMovies(page, false);
        await movieCache.saveNowPlaying(movie);
        final savedMovie = await movieCache.getAllNowPlaying();
        return Right(nowPlayingMovieMapper.mapFromEntityList(savedMovie));
      }
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PopularMovie>>> getAllPopularMovies(
      {bool loadMore = false}) async {
    try {
      final cachedPopularMovies = await movieCache.getAllPopularMovies();
      if (cachedPopularMovies != null && cachedPopularMovies.isNotEmpty) {
        return Right(
            popularMovieEntityMapper.mapFromEntityList(cachedPopularMovies));
      } else {
        final movie = await movieRemote.fetchPopularMovies(loadMore: loadMore);
        await movieCache.savePopularMovies(movie);
        final savedMovie = await movieCache.getAllPopularMovies();
        return Right(popularMovieEntityMapper.mapFromEntityList(savedMovie));
      }
    } catch (e) {
      print(e.toString());
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
      final searchedMovie =
          await movieRemote.searchForMovie(query, page, loadMore: loadMore);
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

  Future<NowPlayingMovieEntity> getNowPlayingMovies(int page, bool loadMore) {
    return movieRemote.fetchAllNowPlayingMovies(
      loadMore: loadMore,
      page: page,
    );
  }

  Future<List<NowPlayingMovieEntity>> loadMoreNowPlayingMovies() async {
    final savedMovies = await movieCache.getAllNowPlaying();
    final movie = savedMovies.first;
    final int currentPage = movie.page += 1;
    final movieResult = movie.results;

    final movieResponse = await getNowPlayingMovies(currentPage, true);
    movieResult.addAll(movieResponse.results);

    movie.page = currentPage;
    await movieCache.updateNowPlaying(movie);

    return movieCache.getAllNowPlaying();
  }
}
