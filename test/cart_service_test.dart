import 'package:flutter_challenge/model/cart_item_model.dart';
import 'package:flutter_challenge/model/offer_model.dart';
import 'package:flutter_challenge/repository/cart_repo.dart';
import 'package:flutter_challenge/service/cart_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

// FakeCartRepo for stubbing database storage during testing
class FakeCartRepo extends CartRepo {
  List<CartItemModel> items = [];

  @override
  Future<List<CartItemModel>> loadCart() async => items;

  @override
  Future<void> saveCart(List<CartItemModel> items) async {
    this.items = items;
  }
  
  @override
  Future<void> addOffer(OfferModel offer, {int quantity = 1}) async {
    final index = items.indexWhere((item) => item.offer.id == offer.id);
    if (index >= 0) {
      final newQuantity = items[index].quantity + quantity;
      final maxQuantity = items[index].offer.quantityLeft;
      items[index] = items[index].copyWith(
        quantity: newQuantity > maxQuantity ? maxQuantity : newQuantity,
      );
    } else {
      final maxQuantity = offer.quantityLeft;
      items.add(CartItemModel(
        offer: offer,
        quantity: quantity > maxQuantity ? maxQuantity : quantity,
      ));
    }
  }

  @override
  Future<void> updateQuantity(String offerId, int quantity) async {
    final index = items.indexWhere((item) => item.offer.id == offerId);
    if (index < 0) return;
    if (quantity <= 0) {
      items.removeAt(index);
    } else {
      final maxQuantity = items[index].offer.quantityLeft;
      items[index] = items[index].copyWith(
        quantity: quantity > maxQuantity ? maxQuantity : quantity,
      );
    }
  }

  @override
  Future<void> clearCart() async {
    items = [];
  }
}

void main() {
  late FakeCartRepo fakeCartRepo;
  late CartService cartService;

  setUp(() {
    // Reset GetX dependency injection container before every test
    Get.reset();
    
    // Inject the Mock Repo
    fakeCartRepo = FakeCartRepo();
    Get.put<CartRepo>(fakeCartRepo);
    
    // Initialize CartService
    cartService = Get.put(CartService());
  });

  // Mock Offer Data
  const bakeryOffer = OfferModel(
    id: 'offer_1',
    title: 'Surprise Bakery Box',
    storeName: 'Green Loaf Bakery',
    category: 'bakery',
    originalPrice: 350,
    discountedPrice: 99,
    quantityLeft: 4,
    imageUrl: 'https://example.com/b1.jpg',
    pickupWindow: '18:00 - 20:00',
    co2Kg: 1.2,
    isFavorite: false,
  );

  const cafeOffer = OfferModel(
    id: 'offer_2',
    title: 'Cafe Pastry Mix',
    storeName: 'Bean & Crumb',
    category: 'cafe',
    originalPrice: 280,
    discountedPrice: 79,
    quantityLeft: 6,
    imageUrl: 'https://example.com/c1.jpg',
    pickupWindow: '19:00 - 21:00',
    co2Kg: 0.8,
    isFavorite: false,
  );

  test('CartItemModel computes lineTotal correctly using discounted price', () {
    const item = CartItemModel(offer: bakeryOffer, quantity: 2);
    expect(item.lineTotal, 99 * 2); // 198
  });

  test('CartService cartTotal is 0 initially when cart is empty', () {
    expect(cartService.items.isEmpty, true);
    expect(cartService.cartTotal, 0);
  });

  test('CartService calculates cartTotal correctly for a single item', () async {
    await cartService.addOffer(bakeryOffer, quantity: 2);
    expect(cartService.cartTotal, 99 * 2); // 198
  });

  test('CartService calculates cartTotal correctly for multiple items in the cart', () async {
    await cartService.addOffer(bakeryOffer, quantity: 2); // 198
    await cartService.addOffer(cafeOffer, quantity: 3); // 237
    expect(cartService.cartTotal, 198 + 237); // 435
  });

  test('CartService defends against adding items exceeding store stock limits', () async {
    // Stock limit of bakeryOffer is 4
    await cartService.addOffer(bakeryOffer, quantity: 2);
    
    // Trying to add 3 more (total 5) should exceed the limit of 4 and throw an exception
    expect(
      () => cartService.addOffer(bakeryOffer, quantity: 3),
      throwsException,
    );
  });
}
