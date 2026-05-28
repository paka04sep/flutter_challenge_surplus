import 'package:flutter_challenge/app_config.dart';
import 'package:flutter_challenge/model/profile_stats_model.dart';
import 'package:flutter_challenge/service/http_service.dart';
import 'package:get/get.dart';

class ProfileRepo extends GetxService {
  final HttpService _httpService = Get.find<HttpService>();

  Future<ProfileStatsModel> fetchStats() async {
    final response = await _httpService.get(
      AppConfig.mockApiHost,
      '/v1/profile/stats',
    );
    return ProfileStatsModel.fromJson(response);
  }
}
