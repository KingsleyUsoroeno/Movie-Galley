import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class SafeApiCall {
  SafeApiCall._();

  ///A more simplified method for making endpoint request call
  ///@param [requestFunction] a function passed, this function is the api call to execute
  ///@Param [statusCodeSuccess] an [int] status code to validate success of the request, if [isStatusCode] == true
  /// Returns [Future<ResponseModel>]
  static Future makeNetworkRequest(Future<Response> Function() requestFunction,
      {int statusCode = 200, Function(dynamic data) successResponse}) async {
    try {
      final response = await requestFunction();
      print(response);

      if (response.statusCode == statusCode) {
        return successResponse(jsonDecode(response.body));
      } else {
        print(response);
        throw Exception("Something went wrong please try again");
      }
    } on SocketException {
      throw Exception("Please check your internet connection and try again");
    } catch (error) {
      print('error --------------------- ${error.toString()}');
      throw Exception(error.toString());
    }
  }
}
