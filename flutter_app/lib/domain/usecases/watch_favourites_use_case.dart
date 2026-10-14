import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/repositories/favourites_repository.dart';

class WatchFavouritesUseCase {
  const WatchFavouritesUseCase(this._repository);

  final FavouritesRepository _repository;

  Stream<List<Meal>> call(String userId) => _repository.watchFavourites(userId);
}
