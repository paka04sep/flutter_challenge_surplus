import 'package:flutter_challenge/feature/cart/cart_screen_controller.dart';
import 'package:get/get.dart';

class CartScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartScreenController>(() => CartScreenController());
  }
}
