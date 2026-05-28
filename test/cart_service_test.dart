import 'package:flutter_challenge/model/cart_item_model.dart';
import 'package:flutter_challenge/model/offer_model.dart';
import 'package:flutter_test/flutter_test.dart';

/// Starter test — candidates may extend for stretch goal S1.
void main() {
  test('cart total uses discounted price (candidate fixes CartService)', () {
    const offer = OfferModel(
      id: 't1',
      title: 'Test',
      storeName: 'Store',
      category: 'bakery',
      originalPrice: 200,
      discountedPrice: 50,
      quantityLeft: 5,
      imageUrl: 'https://example.com/x.jpg',
      pickupWindow: '18:00',
      co2Kg: 1,
      isFavorite: false,
    );
    const item = CartItemModel(offer: offer, quantity: 2);

    // Expected rescue total: 50 * 2 = 100
    // Current buggy CartService would compute 200 * 2 = 400 — see CHALLENGE B3.
    expect(item.lineTotal, 100);
  });
}
