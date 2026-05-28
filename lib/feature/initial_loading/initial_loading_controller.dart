import 'package:flutter_challenge/routes/routes.dart';
import 'package:get/get.dart';

class InitialLoadingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    Routes.navigateToHome();
  }
}
