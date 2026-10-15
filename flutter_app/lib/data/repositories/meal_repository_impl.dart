import 'package:streetbite/data/datasources/local_meal_data_source.dart';
import 'package:streetbite/data/datasources/meal_data_source_factory.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  const MealRepositoryImpl(this._factory, this._local);

  final MealDataSourceFactory _factory;
  final LocalMealDataSource _local;

  @override
  Future<List<Meal>> getMeals({bool forceRefresh = false}) async {
    // Factory Pattern: the factory chooses remote or cached data for this call.
    final source = _factory.create(forceRefresh: forceRefresh);
    try {
      final meals = await source.getMeals();
      if (!identical(source, _local)) await _local.cacheMeals(meals);
      return meals;
    } catch (_) {
      final stale = await _local.getMeals();
      if (stale.isNotEmpty) return stale;
      rethrow;
    }
  }
}
