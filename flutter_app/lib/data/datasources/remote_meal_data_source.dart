import 'package:dio/dio.dart';
import 'package:streetbite/core/constants/app_constants.dart';
import 'package:streetbite/core/errors/error_kind.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/data/datasources/meal_data_source.dart';
import 'package:streetbite/data/models/meal_model.dart';

class RemoteMealDataSource implements MealDataSource {
  const RemoteMealDataSource(this._dio);

  final Dio _dio;

  @override
  Future<List<MealModel>> getMeals() async {
    final responses = await Future.wait(
      AppConstants.mealLetters.map(
        (letter) => _dio.get<Map<String, dynamic>>(
          AppConstants.mealSearchPath,
          queryParameters: {'f': letter},
        ),
      ),
    );
    final byId = <String, MealModel>{};
    for (final response in responses) {
      final list = response.data?['meals'] as List<dynamic>?;
      if (list == null) continue;
      for (final item in list) {
        final meal = MealModel.fromJson(item as Map<String, dynamic>);
        byId[meal.id] = meal;
      }
    }
    if (byId.isEmpty) throw const Failure(ErrorKind.server);
    return byId.values.toList();
  }
}
