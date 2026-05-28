import 'package:flutter/material.dart';
import 'package:flutter_challenge/model/offer_model.dart';
import 'package:flutter_challenge/repository/offer_repo.dart';
import 'package:flutter_challenge/service/cart_service.dart';
import 'package:flutter_challenge/service/the_exceptions.dart';
import 'package:flutter_challenge/util/constants/app_colors.dart';
import 'package:get/get.dart';

class OfferDetailsController extends GetxController {
  final OfferRepo _offerRepo = Get.find<OfferRepo>();
  final CartService _cartService = Get.find<CartService>();

  final RxBool _isLoading = true.obs;
  final RxBool _hasError = false.obs;
  final Rx<OfferModel?> _offer = Rx<OfferModel?>(null);
  final RxInt _quantity = 1.obs;

  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  OfferModel? get offer => _offer.value;
  int get quantity => _quantity.value;

  @override
  void onInit() {
    super.onInit();
    fetchOfferDetails();
  }

  Future<void> fetchOfferDetails() async {
    _isLoading.value = true;
    _hasError.value = false;
    try {
      final id = Get.parameters['id'];
      if (id == null || id.isEmpty) {
        throw TheException('Invalid offer ID');
      }
      final data = await _offerRepo.fetchOfferById(id);
      if (data == null) {
        throw TheException('Offer not found');
      }
      _offer.value = data;
      _quantity.value = 1;
    } on TheException catch (e) {
      _hasError.value = true;
      Get.snackbar('error_generic'.tr, e.displayError());
    } catch (_) {
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }

  void incrementQuantity() {
    final currentOffer = _offer.value;
    if (currentOffer != null && _quantity.value < currentOffer.quantityLeft) {
      _quantity.value++;
    }
  }

  void decrementQuantity() {
    if (_quantity.value > 1) {
      _quantity.value--;
    }
  }

  Future<void> addToBag() async {
    final currentOffer = _offer.value;
    if (currentOffer == null) return;

    if (currentOffer.quantityLeft <= 0) {
      Get.snackbar(
        'error_generic'.tr,
        'No quantity left to add.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      await _cartService.addOffer(currentOffer, quantity: _quantity.value);
      Get.snackbar(
        'app_name'.tr,
        'added_to_bag'.tr,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'error_generic'.tr,
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
