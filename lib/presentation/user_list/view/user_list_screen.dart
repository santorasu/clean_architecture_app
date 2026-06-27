import 'package:clean_architecture_app/core/constansts/color_manger.dart';
import 'package:clean_architecture_app/core/resource/style_manager.dart';
import 'package:clean_architecture_app/core/resource/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/user_viewmodel.dart';
import 'user_detail_screen.dart';
import 'widgets/user_card.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      ref.read(userProvider.notifier).fetchUser();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(userProvider.notifier).fetchMoreUsers();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserState>(userProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        if (previous?.errorMessage != next.errorMessage) {
          Utils.showErrorToast(message: next.errorMessage!);
        }
      }
    });

    final userState = ref.watch(userProvider);
    final rawQuery = userState.searchQuery.toLowerCase();
    final query = rawQuery.trim().replaceAll(RegExp(r'\s+'), ' ');

    // here filter user based on their first name and last name

    final users = query.isEmpty
        ? userState.users
        : userState.users.where((user) {
            final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'
                .toLowerCase();
            return fullName.contains(query);
          }).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Users',
            style: getSemiBold600Style22(color: ColorManager.textPrimary),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () =>
              ref.read(userProvider.notifier).fetchUser(isRefresh: true),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                16.verticalSpace,
                // Search Bar
                TextFormField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  onChanged: (value) =>
                      ref.read(userProvider.notifier).setSearchQuery(value),
                  decoration: InputDecoration(
                    hintText: 'Search by name',
                    prefixIcon: Icon(Icons.search, size: 20.sp),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                  ),
                ),

                16.verticalSpace,

                // Loading / Empty / Error States
                if (userState.isLoading && users.isEmpty)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (userState.errorMessage != null && users.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48.sp,
                            color: ColorManager.errorColor,
                          ),
                          16.verticalSpace,
                          Text(
                            'Failed to load users.',
                            style: getMedium500Style16(
                              color: ColorManager.blackColor,
                            ),
                          ),
                          8.verticalSpace,
                          ElevatedButton(
                            onPressed: () =>
                                ref.read(userProvider.notifier).fetchUser(),
                            child: Text(
                              'Retry',
                              style: getMedium500Style16(
                                color: ColorManager.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (users.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48.sp,
                            color: ColorManager.grayscale70,
                          ),
                          8.verticalSpace,
                          Text(
                            'No users found.',
                            style: getMedium500Style16(
                              color: ColorManager.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount:
                          users.length + (userState.isFetchingMore ? 1 : 0),
                      separatorBuilder: (context, index) => 8.verticalSpace,
                      itemBuilder: (context, index) {
                        if (index == users.length) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final user = users[index];
                        return GestureDetector(
                          onTap: () {
                            searchFocusNode.unfocus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailScreen(user: user),
                              ),
                            );
                          },
                          child: UserCard(user: user),
                        );

                        // This is different way to show Hero Animation for User Image
                        // when click on user image

                        // return Card(
                        //   elevation: 1,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(12.r),
                        //   ),
                        //   child: ListTile(
                        //     contentPadding: EdgeInsets.symmetric(
                        //       horizontal: 16.w,
                        //       vertical: 8.h,
                        //     ),
                        //     leading: Hero(
                        //       tag: 'avatar_${user.id}',
                        //       child: CircleAvatar(
                        //         radius: 24.r,
                        //         backgroundImage: NetworkImage(
                        //           user.avatar ?? '',
                        //         ),
                        //       ),
                        //     ),
                        //     title: Text(
                        //       '${user.firstName ?? ''} ${user.lastName ?? ''}'
                        //           .trim(),
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 16.sp,
                        //       ),
                        //     ),
                        //     subtitle: Text(
                        //       user.email ?? '',
                        //       style: TextStyle(
                        //         color: Colors.grey[600],
                        //         fontSize: 13.sp,
                        //       ),
                        //     ),
                        //     trailing: const Icon(
                        //       Icons.arrow_forward_ios,
                        //       size: 16,
                        //       color: Colors.grey,
                        //     ),
                        //     onTap: () {
                        //       searchFocusNode.unfocus();
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) =>
                        //               UserDetailScreen(user: user),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
