import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/error_kind_message.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/core/utils/snackbar.dart';
import 'package:streetbite/core/utils/validators.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';
import 'package:streetbite/presentation/routing/app_router.dart';
import 'package:streetbite/presentation/widgets/app_text_field.dart';
import 'package:streetbite/presentation/widgets/logo_mark.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().signIn(_email.text, _password.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: BlocConsumer<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    previous.error != current.error && current.error != null,
                listener: (context, state) =>
                    showAppSnackBar(context, state.error!.message(l10n)),
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Center(child: LogoMark(size: 88)),
                        const SizedBox(height: 24),
                        Text(
                          l10n.loginTitle,
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(l10n.loginSubtitle),
                        const SizedBox(height: 24),
                        AppTextField(
                          controller: _email,
                          label: l10n.emailLabel,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => Validators.email(value, l10n),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _password,
                          label: l10n.passwordLabel,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          validator: (value) =>
                              Validators.password(value, l10n),
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: state.isBusy ? null : _submit,
                          child: state.isBusy
                              ? const SizedBox.square(
                                  dimension: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(l10n.loginButton),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed(AppRouter.signUp),
                          child: Text(l10n.noAccountPrompt),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
