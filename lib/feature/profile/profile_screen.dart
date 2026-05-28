import 'package:flutter/material.dart';
import 'package:flutter_challenge/feature/profile/profile_screen_controller.dart';
import 'package:flutter_challenge/feature/shared_widget/main_shell.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';
import 'package:flutter_challenge/util/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainShell(
      currentIndex: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('profile_title'.tr, style: Styles.boldText18()),
          actions: [
            TextButton(
              onPressed: controller.toggleLocale,
              child: Obx(() => Text(controller.localeCode.toUpperCase())),
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final stats = controller.stats;
          if (stats == null) {
            return Center(child: Text('error_generic'.tr));
          }
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _statCard(
                  icon: Icons.restaurant,
                  label: 'meals_rescued'.tr,
                  value: '${stats.mealsRescued}',
                ),
                SizedBox(height: 12.h),
                _statCard(
                  icon: Icons.eco,
                  label: 'co2_saved'.tr,
                  value: '${stats.co2SavedKg.toStringAsFixed(1)} kg',
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: 32),
        title: Text(label, style: Styles.regularText14()),
        trailing: Text(value, style: Styles.boldText18(color: AppColors.primary)),
      ),
    );
  }
}
