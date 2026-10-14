import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/repositories/favourites_repository.dart';

class ToggleFavouriteUseCase {
  const ToggleFavouriteUseCase(this._repository);

  final FavouritesRepository _repository;

  Future<void> call({
    required String userId,
    required Meal meal,
    required bool isFavourite,
  }) {
    return isFavourite
        ? _repository.removeFavourite(userId, meal.id)
        : _repository.addFavourite(userId, meal);
  }
}
