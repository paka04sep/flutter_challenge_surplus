import 'package:flutter_challenge/model/profile_stats_model.dart';
import 'package:flutter_challenge/repository/profile_repo.dart';
import 'package:flutter_challenge/service/localization_service.dart';
import 'package:flutter_challenge/service/the_exceptions.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  final ProfileRepo _profileRepo = Get.find<ProfileRepo>();
  final LocalizationService _localizationService = Get.find<LocalizationService>();

  final RxBool _isLoading = true.obs;
  final Rx<ProfileStatsModel?> _stats = Rx<ProfileStatsModel?>(null);

  bool get isLoading => _isLoading.value;
  ProfileStatsModel? get stats => _stats.value;
  String get localeCode => _localizationService.locale.languageCode;

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  Future<void> fetchStats() async {
    _isLoading.value = true;
    try {
      _stats.value = await _profileRepo.fetchStats();
    } on TheException {
      Get.snackbar('error_generic'.tr, 'error_generic'.tr);
    } finally {
      _isLoading.value = false;
    }
  }

  void toggleLocale() {
    final next = localeCode == 'en' ? 'th' : 'en';
    _localizationService.setLocale(next);
  }
}
