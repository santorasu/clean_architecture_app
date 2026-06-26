import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../network/api_endpoints.dart';
import '../network/error_handle.dart';
import '../network/respose_handle.dart';
import '../../data/sources/local/shared_preference/shared_preference.dart';
import '../route/route_import_part.dart';
import '../route/route_name.dart';

class ApiClient {
  static final Dio _dio = _initDio();

  static Dio _initDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final path = e.requestOptions.path;
            final isAuthPath = path.contains('auth/') || path.contains('login');
            final token = await SharedPreferenceData.getToken();
            if (!isAuthPath && token != null) {
              await SharedPreferenceData.clearAuthData();
              AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(
                RouteName.splashScreen,
                (route) => false,
              );
            }
          }
          return handler.next(e);
        },
      ),
    );
    return dio;
  }

  static Map<String, String>? headers;

  static Future<void> headerSet() async {
    final token = await SharedPreferenceData.getToken();
    log(token ?? 'token');

    headers = {
      'x-api-key': 'reqres_d3aabe93bbf742cdb70fee390c035858',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// GET request
  Future<dynamic> getRequest({required String endpoints}) async {
    await headerSet();
    try {
      log("\n\n\n\nurl :${ApiEndpoints.baseUrl}/$endpoints \n\n\n\n");
      final response = await _dio.get(
        '/$endpoints',
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      // log("\n\n\nGET Request Successful: ${response.data}\n\n\n");
      return ResponseHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        return {
          "status": false,
          "message": ErrorHandle.handleDioError(e),
          "data": null,
        };
      } else {
        log('Non-Dio error: $e');
        return {
          "status": false,
          "message": "An unexpected error occurred: $e",
          "data": null,
        };
      }
    }
  }

  /// POST request
  Future<dynamic> postRequest({
    required String endpoints,
    Map<String, dynamic>? body,

    FormData? formData,
  }) async {
    await headerSet();
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      log("\n\n :$headers\n\n");
      final response = await _dio.post(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      return ResponseHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        // Return the user-friendly error string
        return {
          "status": false,
          "message": ErrorHandle.handleDioError(e),
          "data": null,
        };
      } else {
        return {
          "status": false,
          "message": "An unexpected error occurred: $e",
          "data": null,
        };
      }
    }
  }

  /// PUT request
  Future<dynamic> putRequest({
    required String endpoints,
    required Map<String, dynamic> body,
  }) async {
    await headerSet();
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      log("\n\nurl :$headers\n\n");
      final response = await _dio.put(
        '/$endpoints',
        data: body,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      // debugPrint("\nPUT Request Successful: ${response.data}\n");
      return ResponseHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        return {
          "status": false,
          "message": ErrorHandle.handleDioError(e),
          "data": null,
        };
      } else {
        return {
          "status": false,
          "message": "An unexpected error occurred: $e",
          "data": null,
        };
      }
    }
  }

  /// PATCH request
  Future<dynamic> patchRequest({
    required String endpoints,
    Map<String, dynamic>? body,
    // Map<String, String>? headers,
    FormData? formData,
  }) async {
    await headerSet();
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.patch(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers ?? {"Content-Type": "multipart/form-data"},
        ),
      );

      debugPrint("\nPATCH Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResponseHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        return {
          "status": false,
          "message": ErrorHandle.handleDioError(e),
          "data": null,
        };
      } else {
        return {
          "status": false,
          "message": "An unexpected error occurred: $e",
          "data": null,
        };
      }
    }
  }

  /// Delete request
  Future<dynamic> deleteRequest({required String endpoints}) async {
    await headerSet();
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.delete(
        '/$endpoints',
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );

      debugPrint("delete Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResponseHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        return {
          "status": false,
          "message": ErrorHandle.handleDioError(e),
          "data": null,
        };
      } else {
        return {
          "status": false,
          "message": "An unexpected error occurred: $e",
          "data": null,
        };
      }
    }
  }
}
