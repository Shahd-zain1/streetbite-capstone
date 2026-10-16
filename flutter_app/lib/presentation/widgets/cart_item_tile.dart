import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/widgets/meal_thumbnail.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({required this.item, super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: MealThumbnail(url: item.meal.thumbnail),
        title: Text(
          item.meal.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(l10n.quantityLabel(item.quantity)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.priceFormat(item.total)),
            IconButton(
              tooltip: l10n.removeFromCart,
              icon: const Icon(Icons.delete_outline),
              onPressed: () =>
                  context.read<CartBloc>().add(CartMealRemoved(item.meal.id)),
            ),
          ],
        ),
      ),
    );
  }
}
