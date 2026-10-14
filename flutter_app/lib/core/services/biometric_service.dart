import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:streetbite/core/services/biometric_outcome.dart';

class BiometricService {
  const BiometricService(this._auth);

  final LocalAuthentication _auth;

  Future<BiometricOutcome> authenticate(String reason) async {
    try {
      final supported = await _auth.isDeviceSupported();
      final canCheck = await _auth.canCheckBiometrics;
      if (!supported || !canCheck) return BiometricOutcome.unavailable;
      final ok = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return ok ? BiometricOutcome.success : BiometricOutcome.failed;
    } on PlatformException {
      return BiometricOutcome.failed;
    }
  }
}
