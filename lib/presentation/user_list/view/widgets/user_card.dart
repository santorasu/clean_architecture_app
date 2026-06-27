import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constansts/color_manger.dart';
import '../../../../core/constansts/icon_manager.dart';
import '../../../../core/resource/style_manager.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});

  final Data user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorManager.borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: user.avatar ?? '',
              height: 60.h,
              width: 60.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(
                color: ColorManager.primary,
                strokeWidth: 2.w,
              ),
              errorWidget: (context, url, error) => Image.asset(
                IconManager.profileIcon,
                width: 60.w,
                height: 60.h,
              ),
            ),
          ),
          12.horizontalSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim(),
                style: getMedium500Style16(color: ColorManager.blackColor),
              ),
              8.verticalSpace,
              Text(
                user.email ?? '',
                style: getRegular400Style14(color: ColorManager.blackColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
