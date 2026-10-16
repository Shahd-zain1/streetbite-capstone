import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/presentation/blocs/profile/profile_cubit.dart';
import 'package:streetbite/presentation/blocs/profile/profile_state.dart';
import 'package:streetbite/presentation/widgets/section_title.dart';

class OrdersSection extends StatelessWidget {
  const OrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final format = DateFormat.yMMMd(locale).add_jm();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(l10n.ordersTitle),
        BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) => previous.orders != current.orders,
          builder: (context, state) {
            if (state.orders.isEmpty) return Text(l10n.noOrders);
            return Column(
              children: [
                for (final order in state.orders)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.receipt_long_outlined),
                    title: Text(format.format(order.createdAt)),
                    subtitle: Text(l10n.orderItemsLabel(order.itemCount)),
                    trailing: Text(l10n.priceFormat(order.total)),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
