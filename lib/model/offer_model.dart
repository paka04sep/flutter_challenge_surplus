class OfferModel {
  final String id;
  final String title;
  final String storeName;
  final String category;
  final int originalPrice;
  final int discountedPrice;
  final int quantityLeft;
  final String imageUrl;
  final String pickupWindow;
  final double co2Kg;
  final bool isFavorite;

  const OfferModel({
    required this.id,
    required this.title,
    required this.storeName,
    required this.category,
    required this.originalPrice,
    required this.discountedPrice,
    required this.quantityLeft,
    required this.imageUrl,
    required this.pickupWindow,
    required this.co2Kg,
    required this.isFavorite,
  });

  int get discountPercent {
    if (originalPrice <= 0) {
      return 0;
    }
    return ((originalPrice - discountedPrice) / originalPrice * 100).round();
  }

  OfferModel copyWith({bool? isFavorite}) {
    return OfferModel(
      id: id,
      title: title,
      storeName: storeName,
      category: category,
      originalPrice: originalPrice,
      discountedPrice: discountedPrice,
      quantityLeft: quantityLeft,
      imageUrl: imageUrl,
      pickupWindow: pickupWindow,
      co2Kg: co2Kg,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory OfferModel.fromJson(Map<String, dynamic> data) {
    return OfferModel(
      id: data['id'] as String,
      title: data['title'] as String,
      storeName: data['store_name'] as String,
      category: data['category'] as String,
      originalPrice: data['original_price'] as int,
      discountedPrice: data['discounted_price'] as int,
      quantityLeft: data['quantity_left'] as int,
      imageUrl: data['image_url'] as String,
      pickupWindow: data['pickup_window'] as String,
      // INTENTIONAL BUG (Task B1): API sends co2_kg but this reads wrong key.
      co2Kg: (data['co2_saved_kg'] as num?)?.toDouble() ?? 0,
      isFavorite: data['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'store_name': storeName,
      'category': category,
      'original_price': originalPrice,
      'discounted_price': discountedPrice,
      'quantity_left': quantityLeft,
      'image_url': imageUrl,
      'pickup_window': pickupWindow,
      'co2_kg': co2Kg,
      'is_favorite': isFavorite,
    };
  }
}
