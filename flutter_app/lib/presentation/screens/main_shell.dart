import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/services/biometric_outcome.dart';
import 'package:streetbite/core/services/biometric_service.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/core/utils/snackbar.dart';
import 'package:streetbite/injection.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/blocs/locale/locale_cubit.dart';
import 'package:streetbite/presentation/blocs/theme/theme_bloc.dart';
import 'package:streetbite/presentation/screens/cart_screen.dart';
import 'package:streetbite/presentation/screens/home_screen.dart';
import 'package:streetbite/presentation/screens/profile_screen.dart';
import 'package:streetbite/presentation/screens/vendor_map_screen.dart';
import 'package:streetbite/presentation/widgets/cart_badge_icon.dart';
import 'package:streetbite/presentation/widgets/logo_mark.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _profileIndex = 3;

  int _index = 0;

  Future<void> _select(int index) async {
    if (index == _profileIndex) {
      final l10n = context.l10n;
      final outcome = await getIt<BiometricService>().authenticate(
        l10n.biometricReason,
      );
      if (!mounted) return;
      if (outcome != BiometricOutcome.success) {
        showAppSnackBar(
          context,
          outcome == BiometricOutcome.unavailable
              ? l10n.biometricUnavailable
              : l10n.biometricFailed,
        );
        return;
      }
    }
    setState(() => _index = index);
  }

  Widget _title(BuildContext context) {
    final l10n = context.l10n;
    return switch (_index) {
      0 => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LogoMark(size: 32),
          const SizedBox(width: 8),
          Text(l10n.appName),
        ],
      ),
      1 => Text(l10n.nearbyVendors),
      2 => Text(l10n.cartTitle),
      _ => Text(l10n.profileTitle),
    };
  }

  Widget _body() {
    return switch (_index) {
      0 => const HomeScreen(),
      1 => const VendorMapScreen(),
      2 => const CartScreen(),
      _ => const ProfileScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: _title(context),
        actions: [
          TextButton(
            onPressed: () => context.read<LocaleCubit>().toggle(),
            child: Text(l10n.switchLanguage),
          ),
          IconButton(
            tooltip: l10n.toggleTheme,
            icon: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            onPressed: () =>
                context.read<ThemeBloc>().add(const ThemeToggled()),
          ),
        ],
      ),
      body: _body(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _select,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.map_outlined),
            selectedIcon: const Icon(Icons.map),
            label: l10n.navVendors,
          ),
          NavigationDestination(
            icon: BlocBuilder<CartBloc, CartState>(
              buildWhen: (previous, current) =>
                  previous.itemCount != current.itemCount,
              builder: (context, state) =>
                  CartBadgeIcon(count: state.itemCount),
            ),
            label: l10n.navCart,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}
