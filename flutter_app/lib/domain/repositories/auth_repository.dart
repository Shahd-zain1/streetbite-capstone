import 'package:streetbite/domain/entities/app_user.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> get authChanges;

  Future<void> signIn({required String email, required String password});

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signOut();
}
