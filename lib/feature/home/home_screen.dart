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
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.hasError) {
        return Center(
          child: Text('error_generic'.tr, style: Styles.regularText14()),
        );
      }

      final offers = controller.visibleOffers;
      // INTENTIONAL GAP (Task A4): no empty state widget when offers.isEmpty.
      if (offers.isEmpty) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return OfferCard(
            offer: offer,
            onFavoriteTap: () => controller.toggleFavorite(offer.id),
          );
        },
      );
    });
  }
}
