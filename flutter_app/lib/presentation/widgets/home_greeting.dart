import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/domain/entities/app_user.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';

class HomeGreeting extends StatelessWidget {
  const HomeGreeting({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final AppUser? user = context.select((AuthCubit cubit) => cubit.state.user);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (user != null)
            Text(
              l10n.homeGreeting(user.firstName),
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          Text(l10n.homeSubtitle, style: textTheme.bodyLarge),
        ],
      ),
    );
  }
}
