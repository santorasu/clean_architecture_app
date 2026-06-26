import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constansts/color_manger.dart';
import '../../../core/resource/style_manager.dart';
import '../../../core/route/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteName.userListScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: ColorManager.iconBackground,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20.r,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.people_alt_rounded,
                color: Colors.white,
                size: 60.w,
              ),
            ),

            32.verticalSpace,

            Text(
              "User Directory",
              style: getBold700Style28(color: ColorManager.textPrimary),
            ),

            8.verticalSpace,

            Text(
              "Flutter Developer",
              style: getMedium500Style16(color: ColorManager.textSecondary),
            ),

            48.verticalSpace,

            SizedBox(
              height: 28.h,
              width: 28.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.8,
                color: ColorManager.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
