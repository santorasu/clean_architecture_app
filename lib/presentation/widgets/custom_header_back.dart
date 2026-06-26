import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constansts/color_manger.dart';
import '../../core/resource/style_manager.dart';
import 'back_button.dart';

class CustomHeaderBack extends StatelessWidget {
  const CustomHeaderBack({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: const CustomBackButton(),
          ),
          Text(
            title,
            style: getBold700Style18(
              color: ColorManager.additionalColorWhite,
            ),
          ),
        ],
      ),
    );
  }
}
