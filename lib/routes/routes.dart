import 'package:flutter_challenge/binding/cart_screen_bindings.dart';
import 'package:flutter_challenge/binding/home_screen_bindings.dart';
import 'package:flutter_challenge/binding/initial_loading_bindings.dart';
import 'package:flutter_challenge/binding/profile_screen_bindings.dart';
import 'package:flutter_challenge/feature/cart/cart_screen.dart';
import 'package:flutter_challenge/feature/home/home_screen.dart';
import 'package:flutter_challenge/feature/initial_loading/initial_loading_screen.dart';
import 'package:flutter_challenge/feature/offer_details/offer_details_screen.dart';
import 'package:flutter_challenge/feature/profile/profile_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const String initialLoading = '/loading';
  static const String home = '/';
  static const String offerDetails = '/offer';
  static const String cart = '/cart';
  static const String profile = '/profile';

  static List<GetPage> get all => [
        GetPage(
          name: initialLoading,
          page: () => const InitialLoadingScreen(),
          binding: InitialLoadingBindings(),
        ),
        GetPage(
          name: home,
          page: () => const HomeScreen(),
          binding: HomeScreenBindings(),
        ),
        // INTENTIONAL GAP (Task A2): Offer details route has no binding — candidate adds it.
        GetPage(
          name: offerDetails,
          page: () => const OfferDetailsScreen(),
        ),
        GetPage(
          name: cart,
          page: () => const CartScreen(),
          binding: CartScreenBindings(),
        ),
        GetPage(
          name: profile,
          page: () => const ProfileScreen(),
          binding: ProfileScreenBindings(),
        ),
      ];

  static void navigateToHome() => Get.offAllNamed(home);

  static void navigateToOfferDetails(String offerId) {
    Get.toNamed(offerDetails, parameters: {'id': offerId});
  }

  static void navigateToCart() => Get.toNamed(cart);

  static void navigateToProfile() => Get.toNamed(profile);
}
