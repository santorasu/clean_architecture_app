import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/user_viewmodel.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userProvider.notifier).fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: const Center(child: Text('User List Content')),
    );
  }
}
