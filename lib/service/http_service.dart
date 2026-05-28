import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_challenge/app_config.dart';
import 'package:flutter_challenge/service/the_exceptions.dart';
import 'package:flutter_challenge/util/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/// Mock HTTP layer — reads JSON from assets instead of a real backend.
class HttpService extends GetxService {
  late final http.Client _client;

  @override
  void onInit() {
    super.onInit();
    _client = http.Client();
  }

  @override
  void onClose() {
    _client.close();
    super.onClose();
  }

  Future<Map<String, dynamic>> getMock(String path) async {
    try {
      final assetPath = _mapPathToAsset(path);
      final raw = await rootBundle.loadString(assetPath);
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (e) {
      throw TheException('Failed to load mock API: $path');
    }
  }

  String _mapPathToAsset(String path) {
    if (path.contains('/offers')) {
      return 'assets/mock/offers.json';
    }
    if (path.contains('/profile/stats')) {
      return 'assets/mock/profile_stats.json';
    }
    throw TheException('Unknown mock path: $path');
  }

  Future<Map<String, dynamic>> get(
    String host,
    String path, {
    Map<String, String>? query,
  }) async {
    if (host != AppConfig.mockApiHost) {
      throw TheException('Only mock host is supported in this challenge');
    }
    return getMock(path).timeout(
      const Duration(seconds: AppConstants.HTTP_TIMEOUT_SECONDS),
      onTimeout: () => throw TheException('Request timed out'),
    );
  }
}
