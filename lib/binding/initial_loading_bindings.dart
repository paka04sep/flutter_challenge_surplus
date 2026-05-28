import 'package:flutter_challenge/feature/initial_loading/initial_loading_controller.dart';
import 'package:get/get.dart';

class InitialLoadingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(InitialLoadingController());
  }
}
