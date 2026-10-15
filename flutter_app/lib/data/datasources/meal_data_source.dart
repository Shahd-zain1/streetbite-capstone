import 'package:streetbite/data/models/meal_model.dart';

abstract interface class MealDataSource {
  Future<List<MealModel>> getMeals();
}
