import '../models/user_model.dart';
import '../sources/remote/user_api_service.dart';

class UserRepository {
  final UserApiService remoteSource;

  UserRepository({required this.remoteSource});

  Future<UserModel?> fetchUser({String? page, String? perPage}) async {
    return await remoteSource.fetchUser(page: page, perPage: perPage);
  }
}
