import 'package:streetbite/data/datasources/local_meal_data_source.dart';
import 'package:streetbite/data/datasources/meal_data_source.dart';
import 'package:streetbite/data/datasources/remote_meal_data_source.dart';

// Factory Pattern: callers ask for "a meal source" and this class decides
// between the network and the local cache, so MealRepository never branches
// on where the data lives.
class MealDataSourceFactory {
  const MealDataSourceFactory(this._remote, this._local);

  final RemoteMealDataSource _remote;
  final LocalMealDataSource _local;

  MealDataSource create({required bool forceRefresh}) {
    if (!forceRefresh && _local.hasFreshCache) return _local;
    return _remote;
  }
}
