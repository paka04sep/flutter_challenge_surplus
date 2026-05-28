import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TheNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double? width;
  final BorderRadius? borderRadius;

  const TheNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(12.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width ?? double.infinity,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          color: AppColors.divider,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (_, __, ___) => Container(
          color: AppColors.divider,
          child: const Icon(Icons.broken_image_outlined),
        ),
      ),
    );
  }
}
