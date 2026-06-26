import 'package:clean_architecture_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailScreen extends StatelessWidget {
  final Data user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(fullName),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity, height: 40.h),
            Hero(
              tag: 'avatar_${user.id}',
              child: CircleAvatar(
                radius: 60.r,
                backgroundImage: NetworkImage(user.avatar ?? ''),
              ),
            ),
            24.verticalSpace,
            Text(
              fullName,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            8.verticalSpace,
            Text(
              user.email ?? '',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
            32.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      _buildInfoRow(Icons.person_outline, 'First Name', user.firstName ?? ''),
                      const Divider(height: 24),
                      _buildInfoRow(Icons.person, 'Last Name', user.lastName ?? ''),
                      const Divider(height: 24),
                      _buildInfoRow(Icons.email_outlined, 'Email', user.email ?? ''),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 28.sp),
        16.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[500],
                ),
              ),
              4.verticalSpace,
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
