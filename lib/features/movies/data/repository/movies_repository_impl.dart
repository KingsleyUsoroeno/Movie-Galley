import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/core/network_info.dart';
import 'package:movies/features/movies/data/datasource/movies_local_data_source.dart';
import 'package:movies/features/movies/data/datasource/movies_remote_data_source.dart';
import 'package:movies/features/movies/data/local/database/model/movie_model.dart';
import 'package:movies/features/movies/data/local/database/model/now_playing_movies_model.dart';
import 'package:movies/features/movies/data/local/database/model/popular_movie_model.dart';
import 'package:movies/features/movies/data/remote/model/movies.dart';
import 'package:movies/features/movies/data/remote/model/now_playing.dart';
import 'package:movies/features/movies/data/remote/model/popular_movie.dart';

import 'movies_repository.dart';

typedef Future<Movies> _FetchMoviesCategory();
typedef Future<NowPlayingResponse> _FetchNowPlayingMovies();
typedef Future<PopularMovie> _FetchPopularMovies();
typedef Future<NowPlayingResponse> _FetchMoreNowPlayingMovies();

class MovieRepositoryImpl implements MovieRepository {
  final MoviesRemoteDataSource remoteDataSource;
  final MoviesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({@required this.remoteDataSource, @required this.localDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, MovieDatabaseModel>> fetchAllMovieCategories() async {
    return await _getMovieCategories(() {
      return remoteDataSource.getMovieCategories();
    });
  }

  @override
  Future<Either<Failure, NowPlayingMoviesDatabaseModel>> fetchAllNowPlayingMovies({bool loadMore = false}) async {
    return await _getNowPlayingMovies(() {
      return remoteDataSource.getNowPlayingMovies(loadMore: loadMore);
    });
  }

  @override
  Future<Either<Failure, PopularMoviesDatabaseModel>> fetchAllPopularMovies({bool loadMore = false}) async {
    return await _getPopularMovies(() {
      return remoteDataSource.getPopularMovies(loadMore: loadMore);
    });
  }

  @override
  Future<Either<Failure, NowPlayingMoviesDatabaseModel>> fetchMoreNowPlayingMovies({bool loadMore = false}) async {
    return await _fetchMoreNowPlayingMovies(() {
      return remoteDataSource.getNowPlayingMovies(loadMore: loadMore);
    });
  }

  Future<Either<Failure, MovieDatabaseModel>> _getMovieCategories(_FetchMoviesCategory moviesCategory) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await moviesCategory();
        localDataSource.cacheMovieCategory(movies);
        return Right(movies.toDatabaseModel());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final savedMovieCategory = await localDataSource.getMovieCategories(); // Will throw a Cache Exception if
        // there is no savedMovie in our db
        return Right(savedMovieCategory);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, NowPlayingMoviesDatabaseModel>> _getNowPlayingMovies(_FetchNowPlayingMovies nowPlayingMovies) async {
    if (await networkInfo.isConnected) {
      try {
        final nowPlayingMovie = await nowPlayingMovies();
        localDataSource.cacheNowPlayingMovies(nowPlayingMovie);
        print("initial now playing movie result length is ${nowPlayingMovie.results.length}");
        return Right(nowPlayingMovie.toDatabaseModel());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final savedMovies = await localDataSource.getNowPlayingMovies();
        return Right(savedMovies);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, PopularMoviesDatabaseModel>> _getPopularMovies(_FetchPopularMovies popularMovies) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await popularMovies();
        localDataSource.cachePopularMovies(movies);
        return Right(movies.toDatabaseModel());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final savedMovie = await localDataSource.getPopularMovies();
        return Right(savedMovie);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, NowPlayingMoviesDatabaseModel>> _fetchMoreNowPlayingMovies(_FetchMoreNowPlayingMovies nowPlayingMovie) async {
    if (await networkInfo.isConnected) {
      try {
        print("fetching more now paying movies called");
        final nowPlayingMovies = await nowPlayingMovie();
        final savedMovies = await localDataSource.getNowPlayingMovies();
        savedMovies.results.addAll(nowPlayingMovies.results);
        print("new savedMovies length is ${savedMovies.results.length}");
        localDataSource.updateCacheNowPlayingMovies(savedMovies);
        return Right(await localDataSource.getNowPlayingMovies());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final savedMovies = await localDataSource.getNowPlayingMovies();
        return Right(savedMovies);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Movies>> searchForMovie(String query, {bool loadMore = false}) async {
    try {
      print("searching for movie and query is $query");
      final movies = await remoteDataSource.searchForMovie(query, loadMore: loadMore);
      if (movies != null) {
        return Right(movies);
      } else {
        return Left(ServerFailure(errorMessage: "Failed to fetch movie genre pls try again"));
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
