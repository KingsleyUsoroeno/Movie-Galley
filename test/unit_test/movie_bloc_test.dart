import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/features/movies/data/bloc/movie/movie_category/bloc.dart';
import 'package:movies/features/movies/data/repository/movies_repository.dart';

class MockWeatherRepository extends Mock implements MovieRepository {}

void main() {

  MovieRepository movieRepository;
  MovieBloc movieBloc;

  setUp(() {
    movieRepository = MockWeatherRepository();
    movieBloc = MovieBloc(movieRepository: movieRepository);
  });


  group('Movie Bloc', () {
    test('throws AssertionError if WeatherRepository is null', () {
      expect(
        () => MovieBloc(movieRepository: null),
        throwsA(isAssertionError),
      );
    });
  });

  group('FetchMovies Event', () {
    // TODO: Add Tests
  });
}
