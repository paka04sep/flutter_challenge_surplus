import 'package:flutter_challenge/app_config.dart';
import 'package:flutter_challenge/model/offer_model.dart';
import 'package:flutter_challenge/service/http_service.dart';
import 'package:flutter_challenge/util/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferRepo extends GetxService {
  final HttpService _httpService = Get.find<HttpService>();

  Future<List<OfferModel>> fetchOffers() async {
    final response = await _httpService.get(
      AppConfig.mockApiHost,
      '/v1/offers',
    );
    final items = response['offers'] as List<dynamic>? ?? [];
    final favoriteIds = await _loadFavoriteIds();
    return items
        .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
        .map(
          (offer) => offer.copyWith(
            isFavorite: favoriteIds.contains(offer.id),
          ),
        )
        .toList();
  }

  Future<OfferModel?> fetchOfferById(String id) async {
    final offers = await fetchOffers();
    try {
      return offers.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> toggleFavorite(String offerId) async {
    final prefs = Get.find<SharedPreferences>();
    final ids = await _loadFavoriteIds();
    if (ids.contains(offerId)) {
      ids.remove(offerId);
    } else {
      ids.add(offerId);
    }
    await prefs.setStringList(AppConstants.FAVORITES_PREF_KEY, ids.toList());
    // INTENTIONAL GAP (Task B2): no reactive broadcast — UI must be wired by candidate.
  }

  Future<Set<String>> _loadFavoriteIds() async {
    final prefs = Get.find<SharedPreferences>();
    final stored = prefs.getStringList(AppConstants.FAVORITES_PREF_KEY);
    return stored?.toSet() ?? <String>{};
  }
}
