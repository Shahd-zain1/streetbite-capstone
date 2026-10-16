import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/error_kind_message.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/core/utils/snackbar.dart';
import 'package:streetbite/core/utils/validators.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';
import 'package:streetbite/presentation/widgets/app_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().signUp(_name.text, _email.text, _password.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: BlocConsumer<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    (previous.status != current.status &&
                        current.status == AuthStatus.authenticated) ||
                    (previous.error != current.error && current.error != null),
                listener: (context, state) {
                  if (state.status == AuthStatus.authenticated) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } else {
                    showAppSnackBar(context, state.error!.message(l10n));
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          l10n.signUpTitle,
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(l10n.signUpSubtitle),
                        const SizedBox(height: 24),
                        AppTextField(
                          controller: _name,
                          label: l10n.fullNameLabel,
                          validator: (value) =>
                              Validators.fullName(value, l10n),
                        ),
                        const SizedBox(height: 16),
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
                          validator: (value) =>
                              Validators.password(value, l10n),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _confirm,
                          label: l10n.confirmPasswordLabel,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          validator: (value) => Validators.confirmPassword(
                            value,
                            _password.text,
                            l10n,
                          ),
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
                              : Text(l10n.signUpButton),
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
