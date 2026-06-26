import 'dart:developer';
import 'package:dio/dio.dart';

class ResponseHandle {
  static dynamic handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      log("Success: ${response.data}");
      return response.data;
    }
    throw Exception("Error: ${response.statusCode}");
  }
}
