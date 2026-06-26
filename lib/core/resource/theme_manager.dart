import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constansts/color_manger.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: false,

    // ===== Main Colors =====
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryLight,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.textSecondary,
    splashColor: ColorManager.primary.withValues(alpha: 0.15),
    scaffoldBackgroundColor: ColorManager.background,

    colorScheme: ColorScheme.light(
      primary: ColorManager.primary,
      secondary: ColorManager.primaryDark,
      surface: ColorManager.whiteColor,
      error: ColorManager.errorColor,
    ),

    // ===== Card =====
    cardTheme: CardThemeData(
      color: ColorManager.whiteColor,
      shadowColor: ColorManager.shadowColor,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),

    // ===== AppBar =====
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorManager.textPrimary),
      titleTextStyle: getSemiBold600Style12(
        color: ColorManager.textPrimary,
        fontSize: FontSize.s16,
      ),
    ),

    // ===== Button =====
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grayscale60,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primary.withValues(alpha: 0.15),
    ),

    // ===== Elevated Button =====
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        textStyle: getRegular400Style12(
          color: Colors.white,
          fontSize: FontSize.s16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
      ),
    ),

    // ===== Text =====
    textTheme: TextTheme(
      headlineLarge: getSemiBold600Style12(
        color: ColorManager.textPrimary,
        fontSize: FontSize.s20,
      ),
      titleMedium: getMedium500Style12(
        color: ColorManager.textPrimary,
        fontSize: FontSize.s16,
      ),
      bodyMedium: getRegular400Style12(
        color: ColorManager.textPrimary,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegular400Style12(
        color: ColorManager.textSecondary,
        fontSize: FontSize.s12,
      ),
      labelLarge: getSemiBold600Style12(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
    ),

    // ===== Text Selection =====
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorManager.primary,
      selectionColor: ColorManager.primary.withValues(alpha: 0.2),
      selectionHandleColor: ColorManager.primary,
    ),

    // ===== Input =====
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.containerColor1,

      hintStyle: getRegular400Style14(color: ColorManager.grayscale60),

      labelStyle: getMedium500Style12(color: ColorManager.grayscale70),

      helperStyle: getRegular400Style12(color: ColorManager.textSecondary),

      errorStyle: getRegular400Style12(color: ColorManager.errorColor),

      contentPadding: const EdgeInsets.all(AppPadding.p16),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorManager.borderColor, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: ColorManager.errorColor,
          width: AppSize.s1_5,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: ColorManager.errorColor,
          width: AppSize.s1_5,
        ),
      ),
    ),

    // ===== Divider =====
    dividerColor: ColorManager.dividerColor,

    // ===== Icon =====
    iconTheme: IconThemeData(color: ColorManager.primary, size: AppSize.s24),
  );
}
