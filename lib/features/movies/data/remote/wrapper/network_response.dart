abstract class NetworkResponse {}

class NetworkingException implements NetworkResponse {
  String message;

  NetworkingException(this.message);
}

class NetworkingResponseData<T> implements NetworkResponse {
  T dataResponse;

  NetworkingResponseData(this.dataResponse);
}
