import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../viewmodel/user_viewmodel.dart';
import 'user_detail_screen.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for error messages and show a SnackBar
    ref.listen<UserState>(userProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        if (previous?.errorMessage != next.errorMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    });

    final userState = ref.watch(userProvider);
    final rawQuery = userState.searchQuery.toLowerCase();
    final query = rawQuery.trim().replaceAll(RegExp(r'\s+'), ' ');

    final users = query.isEmpty 
        ? userState.users 
        : userState.users.where((user) {
            final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.toLowerCase();
            return fullName.contains(query);
          }).toList();
    
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Users', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(userProvider.notifier).fetchUser(isRefresh: true),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              16.verticalSpace,
              // Search Bar
              TextFormField(
                controller: searchController,
                onChanged: (value) => ref.read(userProvider.notifier).setSearchQuery(value),
                decoration: InputDecoration(
                  hintText: 'Search by name',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.w),
                ),
              ),

              16.verticalSpace,
              
              // Loading / Empty / Error States
              if (userState.isLoading && users.isEmpty) 
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else if (userState.errorMessage != null && users.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 48.sp, color: Colors.redAccent),
                        16.verticalSpace,
                        Text(
                          'Failed to load users.',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        8.verticalSpace,
                        ElevatedButton(
                          onPressed: () => ref.read(userProvider.notifier).fetchUser(),
                          child: const Text('Retry'),
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
                        Icon(Icons.search_off, size: 48.sp, color: Colors.grey),
                        16.verticalSpace,
                        Text(
                          'No users found.',
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
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
                    itemCount: users.length + (userState.isFetchingMore ? 1 : 0),
                    separatorBuilder: (context, index) => 8.verticalSpace,
                    itemBuilder: (context, index) {
                      if (index == users.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      
                      final user = users[index];
                      return Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          leading: Hero(
                            tag: 'avatar_${user.id}',
                            child: CircleAvatar(
                              radius: 24.r,
                              backgroundImage: NetworkImage(user.avatar ?? ''),
                            ),
                          ),
                          title: Text(
                            '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim(),
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                          ),
                          subtitle: Text(
                            user.email ?? '',
                            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailScreen(user: user),
                            ),
                          );
                        },
                      ),
                    );
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
