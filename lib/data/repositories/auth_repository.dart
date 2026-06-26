// import '../models/api_response_model.dart';
// import '../sources/remote/auth_api_service.dart';
//
// class AuthRepository {
//   final AuthApiServices remote;
//   AuthRepository({required this.remote});
//
//   Future<ResponseModel> register({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String password,
//     required String passwordConfirmation,
//   }) async {
//     return remote.register(
//       firstName: firstName,
//       lastName: lastName,
//       email: email,
//       password: password,
//       passwordConfirmation: passwordConfirmation,
//     );
//   }
//
//   Future<ResponseModel> verifyEmailOtp({
//     required String email,
//     required String code,
//   }) async {
//     return remote.verifyEmailOtp(email: email, code: code);
//   }
//
//   Future<ResponseModel> resendEmailOtp({required String email}) async {
//     return remote.resendEmailOtp(email: email);
//   }
//
//   Future<ResponseModel> login({
//     required String email,
//     required String password,
//     String? fcmToken,
//   }) async {
//     return remote.login(email: email, password: password, fcmToken: fcmToken);
//   }
//
//   Future<ResponseModel> forgotPassword({required String email}) async {
//     return remote.forgotPassword(email: email);
//   }
//
//   Future<ResponseModel> verifyOtp({
//     required String email,
//     required String code,
//   }) async {
//     return remote.verifyOtp(email: email, code: code);
//   }
//
//   Future<ResponseModel> resetPassword({
//     required String email,
//     required String code,
//     required String password,
//     required String confirmPassword,
//   }) async {
//     return remote.resetPassword(
//       email: email,
//       code: code,
//       password: password,
//       confirmPassword: confirmPassword,
//     );
//   }
// }
