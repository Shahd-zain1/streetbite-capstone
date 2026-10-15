import 'package:equatable/equatable.dart';
import 'package:streetbite/core/errors/error_kind.dart';
import 'package:streetbite/domain/entities/meal.dart';

enum MealsStatus { loading, loaded, error }

class MealsState extends Equatable {
  const MealsState({
    this.status = MealsStatus.loading,
    this.meals = const [],
    this.error,
  });

  final MealsStatus status;
  final List<Meal> meals;
  final ErrorKind? error;

  @override
  List<Object?> get props => [status, meals, error];
}
