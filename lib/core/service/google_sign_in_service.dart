// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import 'revenuecat_service.dart';
//
// class GoogleAuthService {
//   final ApiClient apiClient;
//   GoogleAuthService({required this.apiClient});
//
//   static bool _isInitialized = false;
//
//   static Future<void> _ensureInitialized() async {
//     if (!_isInitialized) {
//       await GoogleSignIn.instance.initialize(
//         serverClientId: '728628173063-k2umvj7qlts5qkkt6ht41p0ekdq5epqo.apps.googleusercontent.com',
//       );
//       _isInitialized = true;
//     }
//   }
//
//   /// Get Google access token via Google Sign-In + Firebase Auth
//   /// Returns null if user cancelled or authentication failed
//   static Future<String?> getGoogleAccessToken() async {
//     try {
//       await _ensureInitialized();
//       // 1. Trigger Google Sign-In
//       // ignore: unnecessary_nullable_for_final_variable_declarations
//       final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.authenticate();
//
//       if (googleUser == null) {
//         log('Google sign-in: user cancelled');
//         return null;
//       }
//
//       // 2. Get auth details from Google
//       final GoogleSignInAuthentication googleAuth = googleUser.authentication;
//
//       // 3. Create Firebase credential from Google tokens
//       final credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//       );
//
//       // 4. Sign in with Firebase
//       await FirebaseAuth.instance.signInWithCredential(credential);
//
//       if (googleAuth.idToken == null) {
//         log('Google sign-in: failed to get Google ID token');
//         Utils.showToast(message: 'Google authentication failed', backgroundColor: ColorManager.errorColor, textColor: ColorManager.whiteColor);
//         return null;
//       }
//
//       // 5. Get the OAuth Access Token for the backend
//       final GoogleSignInClientAuthorization authorization = await googleUser.authorizationClient.authorizeScopes([
//         'email',
//         'profile',
//       ]);
//       final accessToken = authorization.accessToken;
//
//       log('Google sign-in: Access token obtained successfully');
//       return accessToken;
//     } catch (e) {
//       log('Google sign-in exception: $e');
//       Utils.showToast(message: 'Error during Google sign-in', backgroundColor: ColorManager.errorColor, textColor: ColorManager.whiteColor);
//       return null;
//     }
//   }
//
//   /// Sign out from Google (useful for logout)
//   static Future<void> signOutGoogle() async {
//     try {
//       await _ensureInitialized();
//       await GoogleSignIn.instance.signOut();
//       await FirebaseAuth.instance.signOut();
//       await RevenueCatService.logOut();
//       log('Google sign-out: success');
//     } catch (e) {
//       log('Google sign-out exception: $e');
//     }
//   }
//
//   /// Full Google sign-in flow: get token → send to backend → save auth token
//   Future<ResponseModel> signInWithGoogle() async {
//     try {
//       // 1. Get Google access token
//       final accessToken = await getGoogleAccessToken();
//       if (accessToken == null) {
//         return ResponseModel(isSuccess: false, message: 'Google sign-in cancelled');
//       }
//
//       // 2. Get FCM token
//       final fcmToken = await SharedPreferenceData.getFcmToken();
//       log('Google sign-in: FCM token is $fcmToken');
//
//       // 3. Send to backend
//       final body = {
//         "token": accessToken,
//         "fcm_token": fcmToken ?? '',
//       };
//
//       final response = await apiClient.postRequest(
//         endpoints: ApiEndpoints.signInWithGoogle,
//         body: body,
//       );
//
//       if (response == null || response is! Map) {
//         return ResponseModel(isSuccess: false, message: 'Invalid response from server');
//       }
//
//       final status = response['status'];
//
//       if (status == true) {
//         final data = response['data'];
//         if (data != null) {
//           final accessToken = data['access_token'];
//           if (accessToken != null) {
//             await SharedPreferenceData.setToken(accessToken);
//           }
//
//           final user = data['user'];
//           if (user != null) {
//             final userId = user['id']?.toString();
//             if (userId != null) {
//               await SharedPreferenceData.setUserId(userId);
//               await RevenueCatService.logIn(userId);
//             }
//             final bool onboardingCompleted = user['onboarding_completed'] == true;
//
//             if (onboardingCompleted) {
//               Utils.showToast(
//                 message: 'Sign-in successful',
//                 backgroundColor: ColorManager.primary,
//                 textColor: ColorManager.blackColor,
//               );
//               return ResponseModel(isSuccess: true, message: 'existing', data: user);
//             } else {
//               Utils.showToast(
//                 message: 'Welcome! Complete your profile.',
//                 backgroundColor: ColorManager.primary,
//                 textColor: ColorManager.blackColor,
//               );
//               return ResponseModel(isSuccess: true, message: 'new', data: user);
//             }
//           }
//         }
//
//         // Fallback if data/user is missing but status is true
//         return ResponseModel(isSuccess: true, message: 'existing');
//       } else {
//         Utils.showToast(
//           message: response['message'] ?? 'Unknown error',
//           backgroundColor: ColorManager.errorColor,
//           textColor: ColorManager.whiteColor,
//         );
//         return ResponseModel(isSuccess: false, message: response['message'] ?? 'Unknown error');
//       }
//     } catch (error) {
//       log('Google sign-in error: $error');
//       return ResponseModel(isSuccess: false, message: error.toString());
//     }
//   }
// }
