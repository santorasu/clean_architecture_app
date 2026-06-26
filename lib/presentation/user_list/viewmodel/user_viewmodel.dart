import 'package:clean_architecture_app/core/network/api_clients.dart';
import 'package:clean_architecture_app/data/models/user_model.dart';
import 'package:clean_architecture_app/data/repositories/profile_repository.dart';
import 'package:clean_architecture_app/data/sources/remote/user_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);

class UserNotifier extends Notifier<UserState> {
  final UserRepository repo = UserRepository(
    remoteSource: UserApiService(apiClient: ApiClient()),
  );

  @override
  UserState build() {
    return UserState();
  }

  Future<void> fetchUser() async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      final data = await repo.fetchUser(page: "1", perPage: "10");
      state = state.copyWith(userModel: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }
}

class UserState {
  final UserModel? userModel;
  final String? errorMessage;
  final bool isLoading;

  UserState({this.userModel, this.errorMessage, this.isLoading = false});

  UserState copyWith({
    UserModel? userModel,
    String? errorMessage,
    bool? isLoading,
    bool clearError = false,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
