import 'package:flutter/material.dart';
import 'package:flutter_challenge/feature/offer_details/offer_details_controller.dart';
import 'package:flutter_challenge/feature/shared_widget/the_network_image.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';
import 'package:flutter_challenge/util/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OfferDetailsScreen extends GetView<OfferDetailsController> {
  const OfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'offer_details'.tr,
          style: Styles.boldText18(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (controller.hasError || controller.offer == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    'error_generic'.tr,
                    style: Styles.mediumText16(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: controller.fetchOfferDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text('loading'.tr,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        }

        final offer = controller.offer!;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Section
              Stack(
                children: [
                  TheNetworkImage(
                    imageUrl: offer.imageUrl,
                    height: 240.h,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 12.h,
                    left: 12.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.badgeDiscount,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '-${offer.discountPercent}%',
                        style: Styles.sBoldText12(color: Colors.white)
                            .copyWith(fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Store & Title
                    Text(
                      offer.storeName,
                      style: Styles.regularText14().copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      offer.title,
                      style: Styles.boldText18().copyWith(
                        fontSize: 22.sp,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Badges row: CO2 Saved & Pickup Time
                    Row(
                      children: [
                        // CO2 badge
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFFE8F9F1), // Very light primary green
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.eco,
                                    color: AppColors.primary, size: 20),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'co2_saved'.tr,
                                        style: Styles.sBoldText12(
                                                color: AppColors.textSecondary)
                                            .copyWith(fontSize: 10.sp),
                                      ),
                                      Text(
                                        '${offer.co2Kg.toStringAsFixed(1)} kg',
                                        style: Styles.boldText18(
                                                color: AppColors.primary)
                                            .copyWith(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Pickup Window badge
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time,
                                    color: Colors.orange, size: 20),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'pickup'.tr,
                                        style: Styles.sBoldText12(
                                                color: AppColors.textSecondary)
                                            .copyWith(fontSize: 10.sp),
                                      ),
                                      Text(
                                        offer.pickupWindow,
                                        style: Styles.boldText18(
                                                color: Colors.orange)
                                            .copyWith(fontSize: 14.sp),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Price & Stock Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '฿${offer.originalPrice}',
                              style: Styles.regularText14().copyWith(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              '฿${offer.discountedPrice}',
                              style: Styles.boldText18(color: AppColors.primary)
                                  .copyWith(
                                fontSize: 28.sp,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            '${offer.quantityLeft} left',
                            style: Styles.sBoldText12(
                                color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    const Divider(color: AppColors.divider),
                    SizedBox(height: 16.h),

                    // Stepper controller row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'quantity'.tr,
                          style:
                              Styles.mediumText16().copyWith(fontSize: 18.sp),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.divider),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: controller.quantity > 1
                                    ? controller.decrementQuantity
                                    : null,
                                icon: const Icon(Icons.remove),
                                color: AppColors.primary,
                                disabledColor: Colors.grey.shade400,
                              ),
                              SizedBox(
                                width: 30.w,
                                child: Text(
                                  '${controller.quantity}',
                                  style: Styles.boldText18(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              IconButton(
                                onPressed:
                                    controller.quantity < offer.quantityLeft
                                        ? controller.incrementQuantity
                                        : null,
                                icon: const Icon(Icons.add),
                                color: AppColors.primary,
                                disabledColor: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 100
                            .h), // Provide enough padding for sticky bottom button
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.isLoading ||
            controller.hasError ||
            controller.offer == null) {
          return const SizedBox.shrink();
        }

        final offer = controller.offer!;
        final totalPrice = offer.discountedPrice * controller.quantity;

        return Container(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 24.h,
            top: 12.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: ElevatedButton(
              onPressed: offer.quantityLeft > 0 ? controller.addToBag : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: Row(
                children: [
                  const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  SizedBox(width: 10.w),
                  Text(
                    'add_to_bag'.tr,
                    style: Styles.boldText18(color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    '฿$totalPrice',
                    style: Styles.boldText18(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
