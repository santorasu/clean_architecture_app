import '../../../core/network/api_clients.dart';
import '../../../core/network/api_endpoints.dart';
import '../../models/user_model.dart';

class UserApiService {
  final ApiClient apiClient;

  UserApiService({required this.apiClient});

  Future<UserModel?> fetchUser({String? page, String? perPage}) async {
    try {
      final res = await apiClient.getRequest(
        endpoints: ApiEndpoints.users(page, perPage),
      );

      if (res is Map<String, dynamic>) {
        if (res['status'] == false) {
          throw Exception(res['message'] ?? 'An error occurred');
        }
        return UserModel.fromJson(res);
      }

      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
