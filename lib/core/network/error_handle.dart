// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';

class ErrorHandle {
  static String handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.badCertificate:
       log("error: ${e.message}");
        return "Bad certificate. Please try again.";
      case DioExceptionType.badResponse:
        log("badResponse: ${e.message}");
        if (e.response != null) {
          log("Status Code: ${e.response?.statusCode}");
          log("Response Data: ${e.response?.data}");
        }
        log("error: ${e.message}");
        if (e.response != null && e.response?.data != null) {
          final data = e.response?.data;
          if (data is Map<String, dynamic>) {
            if (data['message'] != null) {
              final msg = data['message'];
              if (msg is Map<String, dynamic> && msg['message'] != null) {
                return msg['message'].toString();
              }
              return msg.toString();
            }
            if (data['errors'] != null) {
              final errors = data['errors'];
              if (errors is Map<String, dynamic>) {
                final List<String> allErrors = [];
                errors.forEach((key, value) {
                  if (value is List) {
                    allErrors.addAll(value.map((item) => item.toString()));
                  } else {
                    allErrors.add(value.toString());
                  }
                });
                if (allErrors.isNotEmpty) {
                  return allErrors.join('\n');
                }
              }
            }
          }
          return "Server error: ${e.response?.statusCode}";
        }
        return "Server error: ${e.message}";
      case DioExceptionType.cancel:
       log("error: ${e.message}");
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
       log("error: ${e.message}");
        return "Connection error. Please check your internet.";
      case DioExceptionType.connectionTimeout:
       log("error: ${e.message}");
        return "Connection timeout. Please try again.";
      case DioExceptionType.receiveTimeout:
       log("error: ${e.message}");
        return "Receive timeout. Please try again.";
      case DioExceptionType.sendTimeout:
       log("error: ${e.message}");
        return "Send timeout. Please try again.";
      case DioExceptionType.unknown:
       log("error: ${e.message}");
        return "Unknown error occurred. Please try again.";
    }
  }
}