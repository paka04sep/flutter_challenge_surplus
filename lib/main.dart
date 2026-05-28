import 'package:flutter/material.dart';
import 'package:flutter_challenge/app_config.dart';
import 'package:flutter_challenge/routes/routes.dart';
import 'package:flutter_challenge/service/localization_service.dart';
import 'package:flutter_challenge/util/get_di.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const RescueBitesApp());
}

class RescueBitesApp extends StatelessWidget {
  const RescueBitesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = Get.find<LocalizationService>();

    return ScreenUtilInit(
      designSize: const Size(380, 821),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Rescue Bites Challenge',
          debugShowCheckedModeBanner: false,
          theme: AppConfig.appTheme,
          locale: localization.locale,
          fallbackLocale: const Locale('en'),
          translations: _AppTranslations(),
          initialRoute: Routes.initialLoading,
          getPages: Routes.all,
        );
      },
    );
  }
}

class _AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => Get.translations;
}
