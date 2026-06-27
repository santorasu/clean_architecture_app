import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../sources/remote/user_api_service.dart';

class UserRepository {
  final UserApiService remoteSource;

  UserRepository({required this.remoteSource});

  Future<UserModel?> fetchUser({String? page, String? perPage}) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = "cached_users_page_$page";
    final timestampKey = "cached_users_timestamp_page_$page";

    // Check internet connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    final hasInternet = !connectivityResult.contains(ConnectivityResult.none);

    if (hasInternet) {
      try {
        final data = await remoteSource.fetchUser(page: page, perPage: perPage);
        if (data != null) {
          await prefs.setString(cacheKey, jsonEncode(data.toJson()));
          await prefs.setString(timestampKey, DateTime.now().toIso8601String());
        }
        return data;
      } catch (e) {
        // API failed despite having connection, try falling back
        return _getCachedData(prefs, cacheKey, timestampKey, hasInternet);
      }
    } else {
      // Offline mode
      return _getCachedData(prefs, cacheKey, timestampKey, hasInternet);
    }
  }

  UserModel? _getCachedData(SharedPreferences prefs, String cacheKey, String timestampKey, bool hasInternet) {
    final cachedData = prefs.getString(cacheKey);
    final timestampStr = prefs.getString(timestampKey);

    if (cachedData != null && timestampStr != null) {
      final cacheTimestamp = DateTime.parse(timestampStr);
      final cacheAge = DateTime.now().difference(cacheTimestamp);

      // Cache is valid for 1 hour. If offline, return expired cache as fallback.
      if (cacheAge.inHours < 1 || !hasInternet) {
        return UserModel.fromJson(jsonDecode(cachedData));
      } else {
        throw Exception("Cache expired");
      }
    }

    if (!hasInternet) {
      throw Exception("No Internet Connection");
    }
    
    throw Exception("Failed to fetch data");
  }
}
