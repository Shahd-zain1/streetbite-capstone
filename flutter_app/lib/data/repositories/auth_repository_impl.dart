import 'package:firebase_auth/firebase_auth.dart';
import 'package:streetbite/data/datasources/firestore_service.dart';
import 'package:streetbite/data/models/user_builder.dart';
import 'package:streetbite/domain/entities/app_user.dart';
import 'package:streetbite/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirestoreService _firestore;

  @override
  Stream<AppUser?> get authChanges {
    return _auth.userChanges().map(
      (user) => user == null ? null : _toUser(user),
    );
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = credential.user!;
    await user.updateDisplayName(name.trim());
    final profile = UserBuilder()
        .uid(user.uid)
        .name(name.trim())
        .email(email.trim())
        .build();
    await _firestore.mergeUser(user.uid, profile.toJson());
  }

  @override
  Future<void> signOut() => _auth.signOut();

  AppUser _toUser(User user) {
    return UserBuilder()
        .uid(user.uid)
        .name(user.displayName ?? '')
        .email(user.email ?? '')
        .build();
  }
}
