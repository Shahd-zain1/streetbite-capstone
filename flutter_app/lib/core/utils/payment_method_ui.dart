import 'package:flutter/material.dart';
import 'package:streetbite/domain/payment/payment_method.dart';
import 'package:streetbite/l10n/generated/app_localizations.dart';

extension PaymentMethodUi on PaymentMethod {
  String label(AppLocalizations l10n) {
    return switch (this) {
      PaymentMethod.cash => l10n.payCash,
      PaymentMethod.card => l10n.payCard,
    };
  }

  IconData get icon {
    return switch (this) {
      PaymentMethod.cash => Icons.payments_outlined,
      PaymentMethod.card => Icons.credit_card,
    };
  }
}
