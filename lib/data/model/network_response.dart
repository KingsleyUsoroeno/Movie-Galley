class NetworkResponse {}

class NetworkingException extends NetworkResponse {
  String message;

  NetworkingException(this.message);
}

class NetworkingResponseData<T> extends NetworkResponse {
  T dataResponse;

  NetworkingResponseData(this.dataResponse);
}
