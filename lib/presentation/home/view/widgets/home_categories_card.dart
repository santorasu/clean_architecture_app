import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constansts/color_manger.dart';
import '../../../../core/resource/network_image.dart';
import '../../../../core/resource/style_manager.dart';

class HomeCategoriesCard extends StatelessWidget {
  const HomeCategoriesCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.winRate,
    required this.description,
    required this.activePicks,
  });

  final String imageUrl;
  final String title;
  final String winRate;
  final String description;
  final String activePicks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            imageUrl: imageUrl,
            height: 170.h,
            width: double.infinity,
            borderRadius: 12.r,
          ),
          12.verticalSpace,
          Row(
            children: [
              Text(
                title,
                style: getMedium500Style28(
                  color: ColorManager.additionalColorWhite,
                ),
              ),
              8.horizontalSpace,
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: ColorManager.foundationGreen,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  winRate,
                  style: getMedium500Style16(
                    color: ColorManager.foundationGreenDark,
                  ),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            description,
            style: getRegular400Style14(color: ColorManager.subtitleText),
          ),
          20.verticalSpace,
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: ColorManager.containerColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              activePicks,
              style: getMedium500Style16(
                color: ColorManager.additionalColorWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
