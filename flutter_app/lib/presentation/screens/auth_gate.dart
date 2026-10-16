import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';
import 'package:streetbite/presentation/screens/login_screen.dart';
import 'package:streetbite/presentation/screens/main_shell.dart';
import 'package:streetbite/presentation/screens/splash_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _splashDone = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (!_splashDone || state.status == AuthStatus.unknown) {
          return SplashScreen(
            onFinished: () => setState(() => _splashDone = true),
          );
        }
        return state.status == AuthStatus.authenticated
            ? const MainShell()
            : const LoginScreen();
      },
    );
  }
}
