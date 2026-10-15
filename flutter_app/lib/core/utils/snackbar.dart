import 'package:flutter/material.dart';

void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Semantics(
          container: true,
          identifier: 'app_snackbar',
          child: Text(message),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
}
