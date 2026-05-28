class ProfileStatsModel {
  final int mealsRescued;
  final double co2SavedKg;

  const ProfileStatsModel({
    required this.mealsRescued,
    required this.co2SavedKg,
  });

  factory ProfileStatsModel.fromJson(Map<String, dynamic> data) {
    return ProfileStatsModel(
      mealsRescued: data['meals_rescued'] as int? ?? 0,
      co2SavedKg: (data['co2_saved_kg'] as num?)?.toDouble() ?? 0,
    );
  }
}
