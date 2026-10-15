import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/error_mapper.dart';
import 'package:streetbite/domain/entities/app_user.dart';
import 'package:streetbite/domain/usecases/observe_auth_state_use_case.dart';
import 'package:streetbite/domain/usecases/sign_in_use_case.dart';
import 'package:streetbite/domain/usecases/sign_out_use_case.dart';
import 'package:streetbite/domain/usecases/sign_up_use_case.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._signIn,
    this._signUp,
    this._signOut,
    ObserveAuthStateUseCase observeAuthState,
  ) : super(const AuthState()) {
    _subscription = observeAuthState().listen(_onUserChanged);
  }

  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;
  final SignOutUseCase _signOut;
  late final StreamSubscription<AppUser?> _subscription;

  void _onUserChanged(AppUser? user) {
    emit(
      AuthState(
        status: user == null
            ? AuthStatus.unauthenticated
            : AuthStatus.authenticated,
        user: user,
        isBusy: state.isBusy,
        error: state.error,
      ),
    );
  }

  Future<void> signIn(String email, String password) {
    return _run(() => _signIn(email: email, password: password));
  }

  Future<void> signUp(String name, String email, String password) {
    return _run(() => _signUp(name: name, email: email, password: password));
  }

  Future<void> signOut() => _run(_signOut.call);

  Future<void> _run(Future<void> Function() action) async {
    emit(AuthState(status: state.status, user: state.user, isBusy: true));
    try {
      await action();
      emit(AuthState(status: state.status, user: state.user));
    } catch (error) {
      emit(
        AuthState(
          status: state.status,
          user: state.user,
          error: ErrorMapper.map(error).kind,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
