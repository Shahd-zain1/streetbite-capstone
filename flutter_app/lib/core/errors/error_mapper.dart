import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:streetbite/core/errors/error_kind.dart';
import 'package:streetbite/core/errors/failure.dart';

class ErrorMapper {
  ErrorMapper._();

  static Failure map(Object error) {
    if (error is Failure) return error;
    if (error is DioException) return Failure(_fromDio(error));
    if (error is FirebaseException) return Failure(_fromFirebase(error.code));
    return const Failure(ErrorKind.unknown);
  }

  static ErrorKind _fromDio(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => ErrorKind.timeout,
      DioExceptionType.connectionError => ErrorKind.network,
      DioExceptionType.badResponse => ErrorKind.server,
      _ => ErrorKind.unknown,
    };
  }

  static ErrorKind _fromFirebase(String code) {
    return switch (code) {
      'invalid-credential' ||
      'wrong-password' ||
      'user-not-found' ||
      'invalid-email' ||
      'user-disabled' => ErrorKind.invalidCredentials,
      'email-already-in-use' => ErrorKind.emailInUse,
      'weak-password' => ErrorKind.weakPassword,
      'too-many-requests' => ErrorKind.tooManyRequests,
      'network-request-failed' || 'unavailable' => ErrorKind.network,
      'deadline-exceeded' => ErrorKind.timeout,
      'permission-denied' => ErrorKind.permissionDenied,
      _ => ErrorKind.unknown,
    };
  }
}
