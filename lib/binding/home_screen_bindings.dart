import 'package:flutter_challenge/feature/home/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
