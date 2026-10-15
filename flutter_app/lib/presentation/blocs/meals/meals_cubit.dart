import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/error_mapper.dart';
import 'package:streetbite/domain/usecases/get_meals_use_case.dart';
import 'package:streetbite/presentation/blocs/meals/meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  MealsCubit(this._getMeals) : super(const MealsState());

  final GetMealsUseCase _getMeals;

  Future<void> load({bool forceRefresh = false}) async {
    if (state.meals.isEmpty) emit(const MealsState());
    try {
      final meals = await _getMeals(forceRefresh: forceRefresh);
      emit(MealsState(status: MealsStatus.loaded, meals: meals));
    } catch (error) {
      if (state.meals.isEmpty) {
        emit(
          MealsState(
            status: MealsStatus.error,
            error: ErrorMapper.map(error).kind,
          ),
        );
      }
    }
  }
}
