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

  Future<void> fetchUser({bool isRefresh = false}) async {
    if (state.isLoading) return;

    try {
      state = state.copyWith(isLoading: true, clearError: true, currentPage: 1, hasMore: true);
      final data = await repo.fetchUser(page: "1", perPage: "10");
      state = state.copyWith(
        userModel: data,
        users: data?.data ?? [],
        isLoading: false,
        hasMore: (data?.page ?? 1) < (data?.totalPages ?? 1),
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> fetchMoreUsers() async {
    if (state.isLoading || state.isFetchingMore || !state.hasMore) return;

    try {
      state = state.copyWith(isFetchingMore: true, clearError: true);
      final nextPage = state.currentPage + 1;
      final data = await repo.fetchUser(page: nextPage.toString(), perPage: "10");
      
      state = state.copyWith(
        userModel: data,
        users: [...state.users, ...?data?.data],
        isFetchingMore: false,
        currentPage: nextPage,
        hasMore: (data?.page ?? nextPage) < (data?.totalPages ?? nextPage),
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isFetchingMore: false);
    }
  }
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

class UserState {
  final UserModel? userModel;
  final List<Data> users;
  final String? errorMessage;
  final bool isLoading;
  final bool isFetchingMore;
  final int currentPage;
  final bool hasMore;
  final String searchQuery;

  UserState({
    this.userModel,
    this.users = const [],
    this.errorMessage,
    this.isLoading = false,
    this.isFetchingMore = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.searchQuery = '',
  });

  UserState copyWith({
    UserModel? userModel,
    List<Data>? users,
    String? errorMessage,
    bool? isLoading,
    bool? isFetchingMore,
    int? currentPage,
    bool? hasMore,
    String? searchQuery,
    bool clearError = false,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      users: users ?? this.users,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoading: isLoading ?? this.isLoading,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
