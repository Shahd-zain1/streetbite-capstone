import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/error_kind_message.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/core/utils/snackbar.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/blocs/favourites/favourites_cubit.dart';
import 'package:streetbite/presentation/blocs/favourites/favourites_state.dart';
import 'package:streetbite/presentation/widgets/cart_badge_icon.dart';
import 'package:streetbite/presentation/widgets/meal_image.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({required this.meal, super.key});

  final Meal meal;

  Future<void> _toggleFavourite(BuildContext context) async {
    final failure = await context.read<FavouritesCubit>().toggle(meal);
    if (failure != null && context.mounted) {
      showAppSnackBar(context, failure.kind.message(context.l10n));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<CartBloc, CartState>(
      listenWhen: (previous, current) => current.itemCount > previous.itemCount,
      listener: (context, state) =>
          showAppSnackBar(context, l10n.addedToCart(meal.name)),
      builder: (context, cartState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              meal.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              BlocBuilder<FavouritesCubit, FavouritesState>(
                builder: (context, favourites) {
                  final isFavourite = favourites.isFavourite(meal.id);
                  return IconButton(
                    tooltip: isFavourite
                        ? l10n.favouriteRemove
                        : l10n.favouriteAdd,
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                    ),
                    onPressed: () => _toggleFavourite(context),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 16),
                child: CartBadgeIcon(count: cartState.itemCount),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.35,
                  width: double.infinity,
                  child: MealImage(url: meal.thumbnail),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(
                            avatar: const Icon(Icons.restaurant_menu, size: 18),
                            label: Text(meal.category),
                          ),
                          Chip(
                            avatar: const Icon(Icons.public, size: 18),
                            label: Text(l10n.originLabel(meal.area)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.instructionsTitle,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(meal.instructions),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: Text(l10n.addToCart),
                onPressed: () =>
                    context.read<CartBloc>().add(CartMealAdded(meal)),
              ),
            ),
          ),
        );
      },
    );
  }
}
