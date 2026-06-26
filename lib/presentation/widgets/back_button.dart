import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constansts/color_manger.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: ColorManager.whiteColor.withValues(alpha: 0.1),
          border: Border.all(
            color: ColorManager.whiteColor.withValues(alpha: 0.2),
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back,
          color: ColorManager.additionalColorWhite,
          size: 24.h,
        ),
      ),
    );
  }
}
