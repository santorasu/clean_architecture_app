import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constansts/color_manger.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: false,

    // ===== Main colors =====
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryLight,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.textSecondary,
    splashColor: ColorManager.primaryDark,
    scaffoldBackgroundColor: const Color(0xFF121212),

    colorScheme: const ColorScheme.dark().copyWith(
      primary: ColorManager.primary,
      secondary: ColorManager.primaryDark,
      error: ColorManager.errorColor,
      surface: Color(0xFF1E1E1E),
    ),

    // ===== Card Theme =====
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      shadowColor: Colors.black54,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),

    // ===== AppBar Theme =====
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: const Color(0xFF121212),
      elevation: AppSize.s4,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: getSemiBold600Style12(
        color: Colors.white,
        fontSize: FontSize.s16,
      ),
    ),

    // ===== Button Theme =====
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.textSecondary,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryDark,
    ),

    // ===== Elevated Button Theme =====
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

    // ===== Text Theme =====
    textTheme: TextTheme(
      headlineLarge: getSemiBold600Style12(
        color: Colors.white,
        fontSize: FontSize.s20,
      ),
      titleMedium: getMedium500Style12(
        color: Colors.white,
        fontSize: FontSize.s16,
      ),
      bodyMedium: getRegular400Style12(
        color: Colors.white,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegular400Style12(
        color: Colors.white70,
        fontSize: FontSize.s12,
      ),
      labelLarge: getSemiBold600Style12(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
    ),

    // ===== Cursor & Selection Colors =====
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorManager.primary,
      selectionColor: ColorManager.primary.withValues(alpha: 0.2),
      selectionHandleColor: ColorManager.primary,
    ),

    // ===== Input Field Theme =====
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.whiteColor.withValues(alpha: 0.1),

      hintStyle: getRegular400Style14(color: ColorManager.grayscale60),

      labelStyle: getMedium500Style12(color: ColorManager.grayscale70),

      helperStyle: getRegular400Style12(color: ColorManager.blackColor),

      errorStyle: getRegular400Style12(color: ColorManager.errorColor),

      contentPadding: const EdgeInsets.all(AppPadding.p16),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.transparentColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.transparentColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.errorColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.errorColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
    ),
    // ===== Icon Theme =====
    iconTheme: IconThemeData(color: ColorManager.primary, size: AppSize.s24),
  );
}
