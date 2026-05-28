import 'dart:convert';

import 'package:flutter_challenge/model/cart_item_model.dart';
import 'package:flutter_challenge/model/offer_model.dart';
import 'package:flutter_challenge/util/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo extends GetxService {
  Future<List<CartItemModel>> loadCart() async {
    final prefs = Get.find<SharedPreferences>();
    final raw = prefs.getString(AppConstants.CART_PREF_KEY);
    if (raw == null || raw.isEmpty) {
      return [];
    }
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveCart(List<CartItemModel> items) async {
    final prefs = Get.find<SharedPreferences>();
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await prefs.setString(AppConstants.CART_PREF_KEY, encoded);
  }

  Future<void> addOffer(OfferModel offer, {int quantity = 1}) async {
    final items = await loadCart();
    final index = items.indexWhere((item) => item.offer.id == offer.id);
    if (index >= 0) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + quantity,
      );
    } else {
      items.add(CartItemModel(offer: offer, quantity: quantity));
    }
    await saveCart(items);
  }

  Future<void> updateQuantity(String offerId, int quantity) async {
    final items = await loadCart();
    final index = items.indexWhere((item) => item.offer.id == offerId);
    if (index < 0) {
      return;
    }
    if (quantity <= 0) {
      items.removeAt(index);
    } else {
      items[index] = items[index].copyWith(quantity: quantity);
    }
    await saveCart(items);
  }

  Future<void> clearCart() async {
    await saveCart([]);
  }
}
