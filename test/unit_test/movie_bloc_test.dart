import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/movies/data/bloc/movie/movie_category/bloc.dart';
import 'package:movies/features/movies/data/repository/movies_repository.dart';

import 'mock__movie_repository.dart';
import 'mock_database_model.dart';

void main() {
  MovieRepository movieRepository;
  MovieBloc movieBloc;

  //setUp will get run before each test in the group to ensure that every test starts off in the exact same state.
  setUp(() {
    movieRepository = MockMovieRepository();
    movieBloc = MovieBloc(movieRepository: movieRepository);
  });

  tearDown(() {
    movieBloc?.close();
  });

  test('throws AssertionError if WeatherRepository is null', () {
    expect(
      () => MovieBloc(movieRepository: null),
      throwsA(isAssertionError),
    );
  });

  test('initial state is correct', () {
    expect(InitialMovieState(), movieBloc.initialState);
  });

  group('FetchMovies Event', () {
    test('initial state is correct', () {
      expect(InitialMovieState(), movieBloc.initialState);
    });

    test('emits [InitialMovieState, movieLoading, movieError] when FetchMovies is added and fetchAllMovieCategories fails', () {
      when(movieRepository.fetchAllMovieCategories()).thenAnswer((_) async => Left(CacheFailure()));

      // act
      movieBloc.add(FetchMovies());

      //assert
      final expectedResponse = [InitialMovieState(), MovieLoading(), MovieError("Cache Failure")];

      expectLater(movieBloc, emitsInOrder(expectedResponse));
    });

    test('emits [InitialMovieState,movieLoading, MovieLoaded] when FetchMovies is added and fetchAllMovieCategories succeeds', () async {
      final movie = MockDatabaseModel.movie;

      when(movieRepository.fetchAllMovieCategories()).thenAnswer((_) async => Right(movie));

      // act
      movieBloc.add(FetchMovies());

      // assert
      final expectedResponse = [InitialMovieState(), MovieLoading(), MovieLoaded(movie: movie)];

      expectLater(
        movieBloc,
        emitsInOrder(expectedResponse),
      );
    });
  });
}
