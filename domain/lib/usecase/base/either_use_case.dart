import 'package:dartz/dartz.dart';
import 'package:domain/imports/module_imports.dart';

/// A use case in Clean Architecture represents an execution unit of asynchronous work.
/// A [EitherUseCase] exposes a Future which Exposes an Dartz Either Function that
/// Either returns a Failure or the expected result.
///
abstract class EitherUseCase<Params, E> {
  /// Where E is the expected type to return when execute is called */
  Future<Either<Failure, E>> execute(Params params);
}
