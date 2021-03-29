import 'package:dartz/dartz.dart';
import 'package:domain/imports/module_imports.dart';

abstract class EitherUseCase<P, E> {
  Future<Either<Failure, E>> execute(P params);
}
