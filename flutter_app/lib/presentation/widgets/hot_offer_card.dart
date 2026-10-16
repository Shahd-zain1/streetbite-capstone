import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/presentation/routing/app_router.dart';
import 'package:streetbite/presentation/widgets/meal_image.dart';

class HotOfferCard extends StatelessWidget {
  const HotOfferCard({required this.meal, super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.42,
      child: Card(
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
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          size: 18,
                          color: Colors.deepOrange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          context.l10n.priceFormat(meal.price),
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
