import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streetbite/core/constants/app_constants.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(SharedPreferences prefs)
    : _prefs = prefs,
      super(
        Locale(
          prefs.getString(AppConstants.localeKey) ?? AppConstants.englishCode,
        ),
      );

  final SharedPreferences _prefs;

  Future<void> toggle() async {
    final next = state.languageCode == AppConstants.englishCode
        ? const Locale(AppConstants.arabicCode)
        : const Locale(AppConstants.englishCode);
    emit(next);
    await _prefs.setString(AppConstants.localeKey, next.languageCode);
  }
}
