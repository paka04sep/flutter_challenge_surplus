import 'package:flutter_challenge/model/cart_item_model.dart';
import 'package:flutter_challenge/service/cart_service.dart';
import 'package:get/get.dart';

class CartScreenController extends GetxController {
  final CartService _cartService = Get.find<CartService>();

  List<CartItemModel> get items => _cartService.items;
  int get cartTotal => _cartService.cartTotal;
  bool get isEmpty => items.isEmpty;

  @override
  void onInit() {
    super.onInit();
    _cartService.refreshCart();
  }

  Future<void> updateQuantity(String offerId, int quantity) async {
    await _cartService.updateQuantity(offerId, quantity);
  }

  Future<void> clearCart() async {
    await _cartService.clearCart();
  }
}
