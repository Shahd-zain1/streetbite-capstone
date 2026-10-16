import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streetbite/core/constants/app_constants.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc(SharedPreferences prefs)
    : _prefs = prefs,
      super(
        (prefs.getBool(AppConstants.darkModeKey) ?? false)
            ? ThemeMode.dark
            : ThemeMode.light,
      ) {
    on<ThemeToggled>(_onToggled);
  }

  final SharedPreferences _prefs;

  Future<void> _onToggled(ThemeToggled event, Emitter<ThemeMode> emit) async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(next);
    await _prefs.setBool(AppConstants.darkModeKey, next == ThemeMode.dark);
  }
}
