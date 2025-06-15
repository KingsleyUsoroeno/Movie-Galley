import 'package:meta/meta.dart';

class AppException implements Exception {
  const AppException(this.message, this.stackTrace);

  final StackTrace stackTrace;

  /// Use [toString] outside of this class to get a message with the exception type included.
  @visibleForTesting
  @protected
  final String message;

  @override
  // ignore: no_runtimeType_toString, acceptable for exception handling where real type information is more important than performance.
  String toString() => '$runtimeType: $message';
}
