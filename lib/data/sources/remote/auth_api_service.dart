// import 'dart:developer';
// import '../../../core/constansts/color_manger.dart';
// import '../../../core/network/api_clients.dart';
// import '../../../core/network/api_endpoints.dart';
// import '../../../core/resource/utils.dart';
// import '../../models/api_response_model.dart';
// import '../local/shared_preference/shared_preference.dart';
// import '../../../../core/service/revenuecat_service.dart';
//
// class AuthApiServices {
//   final ApiClient apiClient;
//   AuthApiServices({required this.apiClient});
//
//   Future<ResponseModel> register({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String password,
//     required String passwordConfirmation,
//   }) async {
//     final body = {
//       "first_name": firstName,
//       "last_name": lastName,
//       "email": email,
//       "password": password,
//       "password_confirmation": passwordConfirmation,
//     };
//     final res = await apiClient.postRequest(
//       endpoints: ApiEndpoints.register,
//       body: body,
//     );
//     if (res['success'] == true || res['status'] == true) {
//       return ResponseModel(isSuccess: true, message: res["message"]);
//     } else {
//       return ResponseModel(isSuccess: false, message: res["message"]);
//     }
//   }
//
//   Future<ResponseModel> verifyEmailOtp({
//     required String email,
//     required String code,
//   }) async {
//     final body = {"email": email, "code": code};
//
//     final res = await apiClient.postRequest(
//       endpoints: ApiEndpoints.verifyEmailOtp,
//       body: body,
//     );
//     if (res['success'] == true || res['status'] == true) {
//       return ResponseModel(isSuccess: true, message: res["message"]);
//     } else {
//       return ResponseModel(isSuccess: false, message: res["message"]);
//     }
//   }
//
//   Future<ResponseModel> resendEmailOtp({required String email}) async {
//     final body = {"email": email};
//
//     final res = await apiClient.postRequest(
//       endpoints: ApiEndpoints.resendEmailOtp,
//       body: body,
//     );
//     if (res['success'] == true || res['status'] == true) {
//       return ResponseModel(isSuccess: true, message: res["message"]);
//     } else {
//       return ResponseModel(isSuccess: false, message: res["message"]);
//     }
//   }
//
//   Future<ResponseModel> login({
//     required String email,
//     required String password,
//     String? fcmToken,
//   }) async {
//     final body = {"email": email, "password": password, 'fcm_token': fcmToken};
//     final response = await apiClient.postRequest(
//       endpoints: ApiEndpoints.login,
//       body: body,
//     );
//     log(response.toString());
//
//     if (response['success'] == true || response['status'] == true) {
//       await SharedPreferenceData.setToken(response['data']['access_token']);
//
//       // Identify the user in RevenueCat
//       if (response['data'] != null && response['data']['user'] != null) {
//         final userId = response['data']['user']['id']?.toString();
//         if (userId != null) {
//           await SharedPreferenceData.setUserId(userId);
//           await RevenueCatService.logIn(userId);
//         }
//       }
//
//       Utils.showToast(
//         message: response['message'],
//         backgroundColor: ColorManager.primary,
//         textColor: ColorManager.blackColor,
//       );
//       return ResponseModel(
//         isSuccess: true,
//         message: response["message"],
//         data: response['data'],
//       );
//     } else {
//       return ResponseModel(isSuccess: false, message: response["message"]);
//     }
//   }
//
//   Future<ResponseModel> forgotPassword({required String email}) async {
//     final body = {"email": email};
//     final res = await apiClient.postRequest(
//       endpoints: ApiEndpoints.forgetPassword,
//       body: body,
//     );
//     if (res['success'] == true || res['status'] == true) {
//       return ResponseModel(isSuccess: true, message: res["message"]);
//     } else {
//       return ResponseModel(isSuccess: false, message: res["message"]);
//     }
//   }
//
//   Future<ResponseModel> verifyOtp({
//     required String email,
//     required String code,
//   }) async {
//     final body = {"email": email, "code": code};
//
//     final res = await apiClient.postRequest(
//       endpoints: ApiEndpoints.verifyOtp,
//       body: body,
//     );
//     if (res['success'] == true || res['status'] == true) {
//       return ResponseModel(isSuccess: true, message: res["message"]);
//     } else {
//       return ResponseModel(isSuccess: false, message: res["message"]);
//     }
//   }
//
//   Future<ResponseModel> resetPassword({
//     required String email,
//     required String code,
//     required String password,
//     required String confirmPassword,
//   }) async {
//     final body = {
//       "email": email,
//       "code": code,
//       "password": password,
//       "password_confirmation": confirmPassword,
//     };
//     final res = await apiClient.postRequest(
//       endpoints: ApiEndpoints.resetPassword,
//       body: body,
//     );
//     if (res['success'] == true || res['status'] == true) {
//       return ResponseModel(isSuccess: true, message: res["message"]);
//     } else {
//       return ResponseModel(isSuccess: false, message: res["message"]);
//     }
//   }
// }
