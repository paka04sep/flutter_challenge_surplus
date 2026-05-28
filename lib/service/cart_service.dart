import 'package:flutter_challenge/model/cart_item_model.dart';
import 'package:flutter_challenge/model/offer_model.dart';
import 'package:flutter_challenge/repository/cart_repo.dart';
import 'package:flutter_challenge/service/the_exceptions.dart';
import 'package:get/get.dart';

class CartService extends GetxService {
  final CartRepo _cartRepo = Get.find<CartRepo>();

  final RxList<CartItemModel> _items = <CartItemModel>[].obs;
  List<CartItemModel> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  /// INTENTIONAL BUG (Task B3): adds original price instead of discounted price.
  int get cartTotal => _items.fold(
        0,
        (sum, item) => sum + (item.offer.discountedPrice * item.quantity),
      );

  @override
  void onInit() {
    super.onInit();
    refreshCart();
  }

  Future<void> refreshCart() async {
    _items.assignAll(await _cartRepo.loadCart());
  }

  Future<void> addOffer(OfferModel offer, {int quantity = 1}) async {
    final existingItem = _items.firstWhereOrNull((item) => item.offer.id == offer.id);
    final existingQuantity = existingItem?.quantity ?? 0;
    if (existingQuantity + quantity > offer.quantityLeft) {
      throw TheException('cannot_exceed_stock'.tr);
    }
    await _cartRepo.addOffer(offer, quantity: quantity);
    await refreshCart();
  }

  Future<void> updateQuantity(String offerId, int quantity) async {
    final existingItem = _items.firstWhereOrNull((item) => item.offer.id == offerId);
    if (existingItem != null) {
      if (quantity > existingItem.offer.quantityLeft) {
        throw TheException('cannot_exceed_stock'.tr);
      }
    }
    await _cartRepo.updateQuantity(offerId, quantity);
    await refreshCart();
  }

  Future<void> clearCart() async {
    await _cartRepo.clearCart();
    await refreshCart();
  }
}
