import 'package:streetbite/domain/entities/meal.dart';

abstract interface class MealRepository {
  Future<List<Meal>> getMeals({bool forceRefresh = false});
}
