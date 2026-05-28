import 'package:flutter/material.dart';
import 'package:flutter_challenge/feature/cart/cart_screen_controller.dart';
import 'package:flutter_challenge/feature/shared_widget/main_shell.dart';
import 'package:flutter_challenge/feature/shared_widget/the_button.dart';
import 'package:flutter_challenge/feature/shared_widget/the_network_image.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';
import 'package:flutter_challenge/util/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends GetView<CartScreenController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainShell(
      currentIndex: 1,
      child: Scaffold(
        appBar:
            AppBar(title: Text('cart_title'.tr, style: Styles.boldText18())),
        body: Obx(() {
          if (controller.isEmpty) {
            return Center(
              child: Text('cart_empty'.tr, style: Styles.regularText14()),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      child: ListTile(
                        leading: TheNetworkImage(
                          imageUrl: item.offer.imageUrl,
                          height: 56.h,
                          width: 56.w,
                        ),
                        title: Text(item.offer.title,
                            style: Styles.mediumText16()),
                        subtitle: Text(
                          '฿${item.offer.discountedPrice} × ${item.quantity}',
                          style: Styles.regularText14(),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              color: AppColors.primary,
                              onPressed: () => controller.updateQuantity(
                                item.offer.id,
                                item.quantity - 1,
                              ),
                            ),
                            Text('${item.quantity}',
                                style: Styles.mediumText16()),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              color: AppColors.primary,
                              disabledColor: Colors.grey.shade400,
                              onPressed: item.quantity < item.offer.quantityLeft
                                  ? () => controller.updateQuantity(
                                        item.offer.id,
                                        item.quantity + 1,
                                      )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildFooter(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('total'.tr, style: Styles.boldText18()),
              Obx(
                () => Text(
                  '฿${controller.cartTotal}',
                  style: Styles.boldText18(color: AppColors.primary),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          TheButton(
            label: 'checkout'.tr,
            onPressed: () {
              Get.snackbar('Checkout', 'Not implement yet');
            },
          ),
        ],
      ),
    );
  }
}
