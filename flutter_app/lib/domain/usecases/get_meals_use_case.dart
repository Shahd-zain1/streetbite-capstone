import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/repositories/meal_repository.dart';

class GetMealsUseCase {
  const GetMealsUseCase(this._repository);

  final MealRepository _repository;

  Future<List<Meal>> call({bool forceRefresh = false}) =>
      _repository.getMeals(forceRefresh: forceRefresh);
}
