import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class LocalizationService extends GetxService {
  final Rx<Locale> _locale = const Locale('en').obs;
  Locale get locale => _locale.value;

  Future<void> loadTranslations() async {
    final en = await _loadMap('assets/language/en.json');
    final th = await _loadMap('assets/language/th.json');
    Get.addTranslations({
      'en': en,
      'th': th,
    });
  }

  Future<Map<String, String>> _loadMap(String path) async {
    final raw = await rootBundle.loadString(path);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((key, value) => MapEntry(key, value.toString()));
  }

  void setLocale(String code) {
    _locale.value = Locale(code);
    Get.updateLocale(_locale.value);
  }
}
