import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streetbite/data/datasources/firestore_service.dart';
import 'package:streetbite/data/models/meal_model.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/repositories/favourites_repository.dart';

class FavouritesRepositoryImpl implements FavouritesRepository {
  const FavouritesRepositoryImpl(this._firestore);

  static const _field = 'favourites';

  final FirestoreService _firestore;

  @override
  Stream<List<Meal>> watchFavourites(String userId) {
    return _firestore.watchUser(userId).map((data) {
      final raw = (data?[_field] as Map<String, dynamic>?) ?? const {};
      final meals =
          raw.values
              .map((value) => MealModel.fromJson(value as Map<String, dynamic>))
              .toList()
            ..sort((a, b) => a.name.compareTo(b.name));
      return meals;
    });
  }

  @override
  Future<void> addFavourite(String userId, Meal meal) {
    return _firestore.mergeUser(userId, {
      _field: {meal.id: MealModel.fromEntity(meal).toJson()},
    });
  }

  @override
  Future<void> removeFavourite(String userId, String mealId) {
    return _firestore.mergeUser(userId, {
      _field: {mealId: FieldValue.delete()},
    });
  }
}
