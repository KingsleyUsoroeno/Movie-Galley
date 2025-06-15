import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

sealed class Result<T, E extends Exception> {
  const Result();

  const factory Result.success(T value) = Success<T, E>;

  const factory Result.failure(E exception) = Failure<T, E>;

  @useResult
  static Result<(A, B), E> combine2<A, B, E extends Exception>(Result<A, E> a, Result<B, E> b) =>
      a.mapSuccess<Result<(A, B), E>>((value) => b.mapSuccess((other) => (value, other))).flatten;

  @useResult
  static Result<(A, B, C), E> combine3<A, B, C, E extends Exception>(Result<A, E> a, Result<B, E> b, Result<C, E> c) =>
      a
          .mapSuccess<Result<(A, B, C), E>>(
            (value) => b.mapSuccess((other1) => c.mapSuccess((other2) => (value, other1, other2))).flatten,
      )
          .flatten;

  R when<R>({required R Function(T) success, required R Function(E) failure}) => switch (this) {
    Success(:final value) => success(value),
    Failure(:final error) => failure(error),
  };
}

class Success<T, E extends Exception> extends Result<T, E> with EquatableMixin {
  const Success(this.value);

  final T value;

  @override
  List<T> get props => [value];
}

class Failure<T, E extends Exception> extends Result<T, E> with EquatableMixin {
  const Failure(this.error);

  final E error;

  @override
  List<E> get props => [error];
}

extension MapResult<T, E extends Exception> on Result<T, E> {
  Result<R, E> mapSuccess<R>(R Function(T) success) =>
      when(success: (data) => Result.success(success(data)), failure: Result.failure);

  Result<T, R> mapFailure<R extends Exception>(R Function(E) failure) =>
      when(success: Result.success, failure: (error) => Result.failure(failure(error)));
}

extension ThenResult<T, E extends Exception> on Result<T, E> {
  Future<Result<R, E>> thenResult<R>(Future<Result<R, E>> Function(T) fn) async => switch (this) {
    Success(:final value) => await fn(value),
    Failure(:final error) => Result.failure(error),
  };
}

extension FlattenResult<T, E extends Exception> on Result<Result<T, E>, E> {
  @useResult
  Result<T, E> get flatten => when(success: (value) => value, failure: Result.failure);
}