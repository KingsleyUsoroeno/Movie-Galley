class ServerException implements Exception {}

class CacheException implements Exception {
  final String errorMessage;

  CacheException(this.errorMessage);
}

class InternetException implements ServerException {}
