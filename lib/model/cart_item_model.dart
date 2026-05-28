import 'package:flutter_challenge/model/offer_model.dart';

class CartItemModel {
  final OfferModel offer;
  final int quantity;

  const CartItemModel({
    required this.offer,
    required this.quantity,
  });

  int get lineTotal => offer.discountedPrice * quantity;

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      offer: offer,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> data) {
    return CartItemModel(
      offer: OfferModel.fromJson(data['offer'] as Map<String, dynamic>),
      quantity: data['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offer': offer.toJson(),
      'quantity': quantity,
    };
  }
}
