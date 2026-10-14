import 'package:streetbite/core/constants/app_constants.dart';
import 'package:streetbite/l10n/generated/app_localizations.dart';

class Validators {
  Validators._();

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? fullName(String? value, AppLocalizations l10n) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return l10n.nameRequired;
    final first = text.substring(0, 1);
    if (first != first.toUpperCase()) return l10n.nameCapital;
    return null;
  }

  static String? email(String? value, AppLocalizations l10n) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return l10n.emailRequired;
    if (!_emailPattern.hasMatch(text)) return l10n.emailInvalid;
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    final text = value ?? '';
    if (text.isEmpty) return l10n.passwordRequired;
    if (text.length < AppConstants.minPasswordLength) {
      return l10n.passwordShort;
    }
    return null;
  }

  static String? confirmPassword(
    String? value,
    String password,
    AppLocalizations l10n,
  ) {
    if (value != password) return l10n.passwordMismatch;
    return null;
  }
}
