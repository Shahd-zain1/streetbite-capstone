import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/error_kind_message.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/presentation/blocs/favourites/favourites_cubit.dart';
import 'package:streetbite/presentation/blocs/favourites/favourites_state.dart';
import 'package:streetbite/presentation/routing/app_router.dart';
import 'package:streetbite/presentation/widgets/meal_thumbnail.dart';
import 'package:streetbite/presentation/widgets/section_title.dart';

class FavouritesSection extends StatelessWidget {
  const FavouritesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(l10n.favouritesTitle),
        BlocBuilder<FavouritesCubit, FavouritesState>(
          builder: (context, state) {
            if (state.error != null) {
              return Text(state.error!.message(l10n));
            }
            if (state.meals.isEmpty) return Text(l10n.noFavourites);
            return Column(
              children: [
                for (final meal in state.meals)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: MealThumbnail(url: meal.thumbnail),
                    title: Text(meal.name),
                    subtitle: Text(meal.category),
                    trailing: Text(l10n.priceFormat(meal.price)),
                    onTap: () => AppRouter.openMeal(context, meal),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
