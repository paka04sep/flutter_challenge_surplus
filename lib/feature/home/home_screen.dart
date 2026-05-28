import 'package:flutter/material.dart';
import 'package:flutter_challenge/feature/home/home_screen_controller.dart';
import 'package:flutter_challenge/feature/shared_widget/main_shell.dart';
import 'package:flutter_challenge/feature/shared_widget/offer_card.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';
import 'package:flutter_challenge/util/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainShell(
      currentIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('home_title'.tr, style: Styles.boldText18()),
          actions: [
            Obx(() => IconButton(
                  icon: Icon(
                    controller.showFavoritesOnly
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: controller.showFavoritesOnly
                        ? Colors.red
                        : AppColors.textPrimary,
                  ),
                  onPressed: controller.toggleShowFavoritesOnly,
                )),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              _buildSearchBar(),
              SizedBox(height: 12.h),
              _buildFilterChips(),
              SizedBox(height: 12.h),
              Expanded(child: _buildOfferList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'search_hint'.tr,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        filled: true,
        fillColor: Colors.white,
      ),
      // INTENTIONAL GAP (Task A1): onChanged not connected to controller.setSearchQuery.
      onChanged: controller.setSearchQuery,
    );
  }

  Widget _buildFilterChips() {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _filterChip('filter_all'.tr, OfferFilter.all),
            _filterChip('filter_bakery'.tr, OfferFilter.bakery),
            _filterChip('filter_cafe'.tr, OfferFilter.cafe),
            _filterChip('filter_market'.tr, OfferFilter.market),
          ],
        ),
      );
    });
  }

  Widget _filterChip(String label, OfferFilter filter) {
    final isSelected = controller.activeFilter == filter;
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => controller.setFilter(filter),
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        checkmarkColor: AppColors.primary,
      ),
    );
  }

  Widget _buildOfferList() {
    return Obx(() {
      if (controller.isLoading) {
        return _buildShimmerList();
      }
      if (controller.hasError) {
        return Center(
          child: Text('error_generic'.tr, style: Styles.regularText14()),
        );
      }

      final offers = controller.visibleOffers;
      
      if (offers.isEmpty) {
        return RefreshIndicator(
          onRefresh: controller.onRefresh,
          color: AppColors.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              height: 400.h,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    controller.showFavoritesOnly
                        ? Icons.favorite_border
                        : Icons.no_food_outlined,
                    size: 72.r,
                    color: controller.showFavoritesOnly
                        ? Colors.red.withValues(alpha: 0.5)
                        : AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                      controller.showFavoritesOnly
                          ? 'empty_favorites'.tr
                          : 'empty_offers'.tr,
                      style: Styles.mediumText16(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.onRefresh,
        color: AppColors.primary,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: offers.length,
          itemBuilder: (context, index) {
            final offer = offers[index];
            return OfferCard(
              offer: offer,
              onFavoriteTap: () => controller.toggleFavorite(offer.id),
            );
          },
        ),
      );
    });
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => const ShimmerSkeleton(),
    );
  }
}

class ShimmerSkeleton extends StatefulWidget {
  const ShimmerSkeleton({super.key});

  @override
  State<ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Card(
        margin: EdgeInsets.only(bottom: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            Container(
              height: 140.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Placeholder
                  Container(
                    height: 20.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Store name Placeholder
                  Container(
                    height: 14.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Price & Quantity row Placeholder
                  Row(
                    children: [
                      Container(
                        height: 20.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 16.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
