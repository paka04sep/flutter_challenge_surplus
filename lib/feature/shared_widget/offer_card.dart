import 'package:flutter/material.dart';
import 'package:flutter_challenge/feature/shared_widget/the_network_image.dart';
import 'package:flutter_challenge/model/offer_model.dart';
import 'package:flutter_challenge/routes/routes.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';
import 'package:flutter_challenge/util/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferCard extends StatelessWidget {
  final OfferModel offer;
  final VoidCallback onFavoriteTap;

  const OfferCard({
    super.key,
    required this.offer,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Routes.navigateToOfferDetails(offer.id),
      borderRadius: BorderRadius.circular(16.r),
      child: Card(
        margin: EdgeInsets.only(bottom: 12.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                TheNetworkImage(imageUrl: offer.imageUrl, height: 140.h),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: IconButton(
                    onPressed: onFavoriteTap,
                    icon: Icon(
                      offer.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: offer.isFavorite ? Colors.red : Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.badgeDiscount,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      '-${offer.discountPercent}%',
                      style: Styles.sBoldText12(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(offer.title, style: Styles.boldText18()),
                  SizedBox(height: 4.h),
                  Text(offer.storeName, style: Styles.regularText14()),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        '฿${offer.discountedPrice}',
                        style: Styles.boldText18(color: AppColors.primary),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '฿${offer.originalPrice}',
                        style: Styles.regularText14().copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${offer.quantityLeft} left',
                        style: Styles.sBoldText12(),
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
