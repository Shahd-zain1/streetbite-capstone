import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/error_kind_message.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/core/utils/snackbar.dart';
import 'package:streetbite/domain/entities/app_user.dart';
import 'package:streetbite/injection.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/blocs/profile/profile_cubit.dart';
import 'package:streetbite/presentation/blocs/profile/profile_state.dart';
import 'package:streetbite/presentation/widgets/device_info_card.dart';
import 'package:streetbite/presentation/widgets/favourites_section.dart';
import 'package:streetbite/presentation/widgets/orders_section.dart';
import 'package:streetbite/presentation/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final AppUser? user = context.select((AuthCubit cubit) => cubit.state.user);
    if (user == null) return const SizedBox.shrink();
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..start(user.uid),
      child: BlocListener<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) =>
            previous.error != current.error && current.error != null,
        listener: (context, state) =>
            showAppSnackBar(context, state.error!.message(l10n)),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ProfileHeader(user: user),
            const SizedBox(height: 16),
            const DeviceInfoCard(),
            const FavouritesSection(),
            const OrdersSection(),
            const SizedBox(height: 24),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.logout),
              label: Text(l10n.signOut),
              onPressed: () {
                context.read<CartBloc>().add(const CartCleared());
                context.read<AuthCubit>().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
