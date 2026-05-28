import 'package:flutter/material.dart';
import 'package:flutter_challenge/routes/routes.dart';
import 'package:flutter_challenge/service/cart_service.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';
import 'package:get/get.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const MainShell({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final cartService = Get.find<CartService>();

    return Scaffold(
      body: child,
      bottomNavigationBar: Obx(() {
        final badge = cartService.itemCount;
        return NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                if (Get.currentRoute != Routes.home) {
                  Routes.navigateToHome();
                }
                break;
              case 1:
                Routes.navigateToCart();
                break;
              case 2:
                Routes.navigateToProfile();
                break;
            }
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: 'nav_home'.tr,
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: badge > 0,
                label: Text('$badge'),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              selectedIcon: const Icon(Icons.shopping_bag),
              label: 'nav_bag'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: 'nav_profile'.tr,
            ),
          ],
          indicatorColor: AppColors.primary.withValues(alpha: 0.15),
        );
      }),
    );
  }
}
