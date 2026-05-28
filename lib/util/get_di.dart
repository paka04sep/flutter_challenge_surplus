import 'package:flutter_challenge/repository/cart_repo.dart';
import 'package:flutter_challenge/repository/offer_repo.dart';
import 'package:flutter_challenge/repository/profile_repo.dart';
import 'package:flutter_challenge/service/cart_service.dart';
import 'package:flutter_challenge/service/http_service.dart';
import 'package:flutter_challenge/service/localization_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs, permanent: true);

  Get.lazyPut<HttpService>(() => HttpService(), fenix: true);
  Get.lazyPut<LocalizationService>(() => LocalizationService(), fenix: true);
  Get.lazyPut<OfferRepo>(() => OfferRepo(), fenix: true);
  Get.lazyPut<CartRepo>(() => CartRepo(), fenix: true);
  Get.lazyPut<ProfileRepo>(() => ProfileRepo(), fenix: true);
  Get.lazyPut<CartService>(() => CartService(), fenix: true);

  await Get.find<LocalizationService>().loadTranslations();
}
