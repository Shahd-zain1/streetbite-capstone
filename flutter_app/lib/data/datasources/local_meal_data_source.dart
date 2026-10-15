import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:streetbite/core/constants/app_constants.dart';
import 'package:streetbite/data/datasources/meal_data_source.dart';
import 'package:streetbite/data/models/meal_model.dart';

class LocalMealDataSource implements MealDataSource {
  const LocalMealDataSource(this._prefs);

  final SharedPreferences _prefs;

  bool get hasFreshCache {
    final savedAt = _prefs.getInt(AppConstants.mealsCachedAtKey);
    if (savedAt == null || !_prefs.containsKey(AppConstants.mealsCacheKey)) {
      return false;
    }
    final age = DateTime.now().difference(
      DateTime.fromMillisecondsSinceEpoch(savedAt),
    );
    return age < AppConstants.cacheLifetime;
  }

  @override
  Future<List<MealModel>> getMeals() async {
    final raw = _prefs.getString(AppConstants.mealsCacheKey);
    if (raw == null) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((item) => MealModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on FormatException {
      return [];
    }
  }

  Future<void> cacheMeals(List<MealModel> meals) async {
    await _prefs.setString(
      AppConstants.mealsCacheKey,
      jsonEncode(meals.map((meal) => meal.toJson()).toList()),
    );
    await _prefs.setInt(
      AppConstants.mealsCachedAtKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }
}
