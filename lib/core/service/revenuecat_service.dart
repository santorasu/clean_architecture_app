// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
//
// class RevenueCatService {
//   // Replace with your specific API keys based on platform if you have separate ones
//   static const String _apiKeyAndroid = 'test_vJWxPDPzaCkOwienQRoPacKBcAs';
//   // static const String _apiKeyApple = 'apple_api_key_here'; // Replace when iOS key is provided
//
//   static const String entitlementPro = 'PICKS EMPIRE Pro';
//
//   /// Initializes the RevenueCat SDK
//   static Future<void> initialize() async {
//     try {
//       await Purchases.setLogLevel(LogLevel.debug);
//
//       late PurchasesConfiguration configuration;
//
//       // In a real app, you would configure both. For now, since the user only
//       // provided one API key, we will use it for Android.
//       if (Platform.isAndroid) {
//         configuration = PurchasesConfiguration(_apiKeyAndroid);
//       } else if (Platform.isIOS) {
//         // configuration = PurchasesConfiguration(_apiKeyApple);
//         // Fallback to the Android one if the user wants to test iOS with the same project (not recommended by RC)
//         configuration = PurchasesConfiguration(_apiKeyAndroid);
//       } else {
//         return;
//       }
//
//       await Purchases.configure(configuration);
//       log('RevenueCat: Initialization successful');
//     } catch (e) {
//       log('RevenueCat: Failed to initialize. Error: $e');
//     }
//   }
//
//   /// Logs in the user with an internal User ID
//   static Future<void> logIn(String appUserId) async {
//     try {
//       final LogInResult result = await Purchases.logIn(appUserId);
//       log('RevenueCat: Logged in user: $appUserId. Created: ${result.created}');
//     } on PlatformException catch (e) {
//       log('RevenueCat: Failed to log in. Error: $e');
//     }
//   }
//
//   /// Logs out the user
//   static Future<void> logOut() async {
//     try {
//       await Purchases.logOut();
//       log('RevenueCat: Logged out successfully');
//     } on PlatformException catch (e) {
//       log('RevenueCat: Failed to log out. Error: $e');
//     }
//   }
//
//   /// Checks if the user has the active 'PICKS EMPIRE Pro' entitlement
//   static Future<bool> isUserPro() async {
//     try {
//       final CustomerInfo customerInfo = await Purchases.getCustomerInfo();
//       if (customerInfo.entitlements.all[entitlementPro] != null &&
//           customerInfo.entitlements.all[entitlementPro]!.isActive) {
//         return true;
//       }
//       return false;
//     } on PlatformException catch (e) {
//       log('RevenueCat: Failed to get customer info. Error: $e');
//       return false;
//     }
//   }
//
//   /// Presents the RevenueCat Paywall directly
//   static Future<void> presentPaywall() async {
//     try {
//       final PaywallResult result = await RevenueCatUI.presentPaywallIfNeeded(
//         entitlementPro,
//       );
//       log('RevenueCat: Paywall closed with result: $result');
//     } catch (e) {
//       log('RevenueCat: Failed to present paywall. Error: $e');
//     }
//   }
//
//   /// Purchases the default active subscription package from RevenueCat
//   static Future<bool> purchaseSubscription(BuildContext context) async {
//     try {
//       final offerings = await Purchases.getOfferings();
//       if (offerings.current != null && offerings.current!.availablePackages.isNotEmpty) {
//         // Typically, the first available package in the current offering is the default subscription
//         final package = offerings.current!.availablePackages.first;
//         final purchaseParams = PurchaseParams.package(package);
//         final purchaseResult = await Purchases.purchase(purchaseParams);
//
//         final customerInfo = purchaseResult.customerInfo;
//         if (customerInfo.entitlements.all[entitlementPro] != null &&
//             customerInfo.entitlements.all[entitlementPro]!.isActive) {
//           log('RevenueCat: Purchase successful!');
//           return true;
//         }
//       } else {
//         log('RevenueCat: No offerings found.');
//       }
//     } on PlatformException catch (e) {
//       final errorCode = PurchasesErrorHelper.getErrorCode(e);
//       if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
//         log('RevenueCat: User cancelled the purchase.');
//       } else {
//         log('RevenueCat: Purchase failed. Error: $e');
//       }
//     } catch (e) {
//       log('RevenueCat: Unexpected error during purchase: $e');
//     }
//     return false;
//   }
//
//   /// Presents the RevenueCat Customer Center (if configured in RevenueCat dashboard)
//   static Future<void> presentCustomerCenter() async {
//     try {
//       await RevenueCatUI.presentCustomerCenter();
//     } catch (e) {
//       log('RevenueCat: Failed to present customer center. Error: $e');
//     }
//   }
// }
