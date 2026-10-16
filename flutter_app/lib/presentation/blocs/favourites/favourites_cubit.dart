import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/error_kind.dart';
import 'package:streetbite/core/errors/error_mapper.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/usecases/toggle_favourite_use_case.dart';
import 'package:streetbite/domain/usecases/watch_favourites_use_case.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';
import 'package:streetbite/presentation/blocs/favourites/favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit(
    this._watchFavourites,
    this._toggleFavourite,
    AuthCubit authCubit,
  ) : super(const FavouritesState()) {
    _authSubscription = authCubit.stream.listen(_onAuthChanged);
    _onAuthChanged(authCubit.state);
  }

  final WatchFavouritesUseCase _watchFavourites;
  final ToggleFavouriteUseCase _toggleFavourite;
  late final StreamSubscription<AuthState> _authSubscription;
  StreamSubscription<List<Meal>>? _favouritesSubscription;
  String? _userId;

  void _onAuthChanged(AuthState authState) {
    final userId = authState.user?.uid;
    if (userId == _userId) return;
    _userId = userId;
    _favouritesSubscription?.cancel();
    if (userId == null) {
      _favouritesSubscription = null;
      emit(const FavouritesState());
      return;
    }
    _favouritesSubscription = _watchFavourites(userId).listen(
      (meals) => emit(FavouritesState(meals: meals)),
      onError: (Object error) => emit(
        FavouritesState(meals: state.meals, error: ErrorMapper.map(error).kind),
      ),
    );
  }

  Future<Failure?> toggle(Meal meal) async {
    final userId = _userId;
    if (userId == null) return const Failure(ErrorKind.unknown);
    try {
      await _toggleFavourite(
        userId: userId,
        meal: meal,
        isFavourite: state.isFavourite(meal.id),
      );
      return null;
    } catch (error) {
      return ErrorMapper.map(error);
    }
  }

  @override
  Future<void> close() async {
    await _authSubscription.cancel();
    await _favouritesSubscription?.cancel();
    return super.close();
  }
}
