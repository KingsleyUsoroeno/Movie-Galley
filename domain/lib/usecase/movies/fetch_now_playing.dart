import 'package:dartz/dartz.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/imports/module_imports.dart';
import 'package:domain/usecase/base/either_use_case.dart';

class FetchNowPlaying extends EitherUseCase<bool, List<Movie>> {
  final MovieRepository movieRepository;

  FetchNowPlaying({this.movieRepository});

  @override
  Future<Either<Failure, List<Movie>>> execute(bool params) {
    return movieRepository.getAllNowPlayingMovies(loadMore: params);
  }
}
