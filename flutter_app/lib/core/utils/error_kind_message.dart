import 'package:streetbite/core/errors/error_kind.dart';
import 'package:streetbite/l10n/generated/app_localizations.dart';

extension ErrorKindMessage on ErrorKind {
  String message(AppLocalizations l10n) {
    return switch (this) {
      ErrorKind.network => l10n.errNetwork,
      ErrorKind.timeout => l10n.errTimeout,
      ErrorKind.server => l10n.errServer,
      ErrorKind.invalidCredentials => l10n.errInvalidCredentials,
      ErrorKind.emailInUse => l10n.errEmailInUse,
      ErrorKind.weakPassword => l10n.errWeakPassword,
      ErrorKind.tooManyRequests => l10n.errTooManyRequests,
      ErrorKind.permissionDenied => l10n.errPermissionDenied,
      ErrorKind.paymentFailed => l10n.errPaymentFailed,
      ErrorKind.unknown => l10n.errUnknown,
    };
  }
}
