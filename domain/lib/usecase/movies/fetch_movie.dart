import 'package:dartz/dartz.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/model/movie.dart';
import 'package:domain/repository/movie_repository.dart';
import 'package:domain/usecase/base/either_use_case.dart';

class FetchMovie implements EitherUseCase<String, List<Movie>> {
  final MovieRepository movieRepository;

  FetchMovie({
    this.movieRepository,
  });

  @override
  Future<Either<Failure, List<Movie>>> execute(String params) {
    return movieRepository.getAllMovieCategories();
  }
}
