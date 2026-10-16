import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/core/utils/snackbar.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/routing/app_router.dart';
import 'package:streetbite/presentation/widgets/meal_image.dart';

class MealCard extends StatelessWidget {
  const MealCard({required this.meal, super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => AppRouter.openMeal(context, meal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox.expand(child: MealImage(url: meal.thumbnail)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 4, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall,
                  ),
                  Text(
                    meal.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.priceFormat(meal.price),
                          style: textTheme.labelLarge,
                        ),
                      ),
                      Semantics(
                        container: true,
                        identifier: 'add_to_cart_${meal.id}',
                        child: IconButton.filled(
                          tooltip: l10n.addToCart,
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.add_shopping_cart, size: 20),
                          onPressed: () {
                            context.read<CartBloc>().add(CartMealAdded(meal));
                            showAppSnackBar(
                              context,
                              l10n.addedToCart(meal.name),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
