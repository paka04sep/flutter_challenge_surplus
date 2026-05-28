import 'package:flutter_challenge/feature/offer_details/offer_details_controller.dart';
import 'package:get/get.dart';

class OfferDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferDetailsController>(() => OfferDetailsController());
  }
}
