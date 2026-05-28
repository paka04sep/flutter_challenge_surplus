import 'package:flutter/material.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';
import 'package:flutter_challenge/util/styles.dart';
import 'package:get/get.dart';

class InitialLoadingScreen extends StatelessWidget {
  const InitialLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.eco, size: 64, color: AppColors.primary),
            const SizedBox(height: 16),
            Text('app_name'.tr, style: Styles.boldText18()),
            const SizedBox(height: 24),
            const CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(height: 8),
            Text('loading'.tr, style: Styles.regularText14()),
          ],
        ),
      ),
    );
  }
}
