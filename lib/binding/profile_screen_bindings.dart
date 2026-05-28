import 'package:flutter_challenge/feature/profile/profile_screen_controller.dart';
import 'package:get/get.dart';

class ProfileScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
