import 'package:equatable/equatable.dart';
import 'package:streetbite/core/errors/error_kind.dart';
import 'package:streetbite/domain/entities/meal.dart';

class FavouritesState extends Equatable {
  const FavouritesState({this.meals = const [], this.error});

  final List<Meal> meals;
  final ErrorKind? error;

  bool isFavourite(String mealId) => meals.any((meal) => meal.id == mealId);

  @override
  List<Object?> get props => [meals, error];
}
