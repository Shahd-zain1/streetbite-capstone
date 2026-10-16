import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/error_kind_message.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/core/utils/payment_method_ui.dart';
import 'package:streetbite/core/utils/snackbar.dart';
import 'package:streetbite/domain/payment/payment_method.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/widgets/cart_item_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  PaymentMethod _method = PaymentMethod.cash;

  void _placeOrder() {
    final userId = context.read<AuthCubit>().state.user!.uid;
    context.read<CartBloc>().add(
      CartOrderPlaced(userId: userId, method: _method),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocListener(
      listeners: [
        BlocListener<CartBloc, CartState>(
          listenWhen: (previous, current) =>
              previous.items.isNotEmpty &&
              current.items.isEmpty &&
              current.status != CartStatus.placed,
          listener: (context, state) =>
              showAppSnackBar(context, l10n.cartBecameEmpty),
        ),
        BlocListener<CartBloc, CartState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              (current.status == CartStatus.placed ||
                  current.status == CartStatus.failed),
          listener: (context, state) => showAppSnackBar(
            context,
            state.status == CartStatus.placed
                ? l10n.orderPlaced
                : state.error!.message(l10n),
          ),
        ),
      ],
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 12),
                  Text(l10n.cartEmpty, style: textTheme.titleMedium),
                ],
              ),
            );
          }
          final isPlacing = state.status == CartStatus.placing;
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (_, index) =>
                      CartItemTile(item: state.items[index]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(l10n.paymentMethodTitle, style: textTheme.titleSmall),
                    const SizedBox(height: 8),
                    SegmentedButton<PaymentMethod>(
                      segments: [
                        for (final method in PaymentMethod.values)
                          ButtonSegment(
                            value: method,
                            icon: Icon(method.icon),
                            label: Text(method.label(l10n)),
                          ),
                      ],
                      selected: {_method},
                      onSelectionChanged: (selection) =>
                          setState(() => _method = selection.first),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.totalLabel,
                            style: textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          l10n.priceFormat(state.total),
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: isPlacing ? null : _placeOrder,
                      child: isPlacing
                          ? const SizedBox.square(
                              dimension: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.placeOrder),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
