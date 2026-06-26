import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constansts/color_manger.dart';
import '../../core/resource/style_manager.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final double? borderRadius;
  final void Function()? onTap;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? containerColor;
  final Border? border;
  const PrimaryButton({
    super.key,
    this.borderRadius,
    required this.title,
    required this.onTap,
    this.width,
    this.padding,
    this.textStyle,
    this.containerColor,
    this.border,
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? double.infinity.w,

        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
          color: containerColor ?? ColorManager.primary,
          border: border ?? Border.all(color: ColorManager.transparentColor),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 24.h,
                  width: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorManager.blackColor,
                  ),
                )
              : Text(
                  title,
                  style:
                      textStyle ??
                      getSemiBold600Style18(color: ColorManager.buttonText),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
    );
  }
}
