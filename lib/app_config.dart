import 'package:flutter/material.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';

class AppConfig {
  static const String mockApiHost = 'mock.rescuebites.local';

  static ThemeData get appTheme {
    return ThemeData(
      primarySwatch: AppColors.primarySwatch,
      scaffoldBackgroundColor: AppColors.scaffold,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBar,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
    );
  }
}
