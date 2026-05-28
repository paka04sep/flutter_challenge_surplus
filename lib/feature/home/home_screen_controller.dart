import 'package:flutter_challenge/model/offer_model.dart';
import 'package:flutter_challenge/repository/offer_repo.dart';
import 'package:flutter_challenge/service/the_exceptions.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum OfferFilter { all, bakery, cafe, market }

class HomeScreenController extends GetxController {
  final OfferRepo _offerRepo = Get.find<OfferRepo>();

  final RxBool _isLoading = true.obs;
  final RxBool _hasError = false.obs;
  final RxList<OfferModel> _offers = <OfferModel>[].obs;
  final Rx<OfferFilter> _activeFilter = OfferFilter.all.obs;
  final RxString _searchQuery = ''.obs;
  final RxBool _showFavoritesOnly = false.obs;

  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  List<OfferModel> get offers => _offers;
  OfferFilter get activeFilter => _activeFilter.value;
  String get searchQuery => _searchQuery.value;
  bool get showFavoritesOnly => _showFavoritesOnly.value;

  List<OfferModel> get visibleOffers {
    final query = _searchQuery.value.trim().toLowerCase();
    final filter = _activeFilter.value;
    final showFavs = _showFavoritesOnly.value;

    return _offers.where((offer) {
      // 1. Favorites Screen-Level Filter
      if (showFavs && !offer.isFavorite) {
        return false;
      }

      // 2. Category Filter
      if (filter != OfferFilter.all &&
          offer.category.toLowerCase() != filter.name.toLowerCase()) {
        return false;
      }

      // 3. Search Query Filter
      final matchesSearch = query.isEmpty ||
          offer.title.toLowerCase().contains(query) ||
          offer.storeName.toLowerCase().contains(query);
      return matchesSearch;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadPersistedStates();
    fetchOffers();
  }

  void _loadPersistedStates() {
    try {
      final prefs = Get.find<SharedPreferences>();
      
      // Load active category filter
      final storedFilter = prefs.getString('home_active_filter');
      if (storedFilter != null) {
        _activeFilter.value = OfferFilter.values.firstWhere(
          (e) => e.name == storedFilter,
          orElse: () => OfferFilter.all,
        );
      }
      
      // Load show favorites only state
      final storedFavs = prefs.getBool('home_show_favorites_only');
      if (storedFavs != null) {
        _showFavoritesOnly.value = storedFavs;
      }
    } catch (_) {}
  }

  Future<void> fetchOffers() async {
    _isLoading.value = true;
    _hasError.value = false;
    try {
      final data = await _offerRepo.fetchOffers();
      _offers.assignAll(data);
    } on TheException catch (e) {
      _hasError.value = true;
      Get.snackbar('error_generic'.tr, e.displayError());
    } finally {
      _isLoading.value = false;
    }
  }

  void setFilter(OfferFilter filter) {
    _activeFilter.value = filter;
    try {
      final prefs = Get.find<SharedPreferences>();
      prefs.setString('home_active_filter', filter.name);
    } catch (_) {}
  }

  void toggleShowFavoritesOnly() {
    _showFavoritesOnly.value = !_showFavoritesOnly.value;
    try {
      final prefs = Get.find<SharedPreferences>();
      prefs.setBool('home_show_favorites_only', _showFavoritesOnly.value);
    } catch (_) {}
  }

  void setSearchQuery(String value) {
    _searchQuery.value = value;
  }

  Future<void> toggleFavorite(String offerId) async {
    await _offerRepo.toggleFavorite(offerId);
    final index = _offers.indexWhere((offer) => offer.id == offerId);
    if (index >= 0) {
      final currentOffer = _offers[index];
      _offers[index] = currentOffer.copyWith(isFavorite: !currentOffer.isFavorite);
    }
  }

  Future<void> onRefresh() => fetchOffers();
}
