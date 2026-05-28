import 'package:flutter/material.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  static TextStyle boldText18({Color? color}) => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle mediumText16({Color? color}) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle regularText14({Color? color}) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textSecondary,
      );

  static TextStyle sBoldText12({Color? color}) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
      );
}
