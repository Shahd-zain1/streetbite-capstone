import 'package:equatable/equatable.dart';
import 'package:streetbite/core/errors/error_kind.dart';
import 'package:streetbite/domain/entities/app_user.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.isBusy = false,
    this.error,
  });

  final AuthStatus status;
  final AppUser? user;
  final bool isBusy;
  final ErrorKind? error;

  @override
  List<Object?> get props => [status, user, isBusy, error];
}
