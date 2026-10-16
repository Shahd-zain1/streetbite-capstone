import 'package:flutter/material.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/presentation/widgets/meal_card.dart';

class SliverMealsGrid extends StatelessWidget {
  const SliverMealsGrid({required this.meals, super.key});

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cardWidth = (width - 16 * 2 - 12) / 2;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: cardWidth * 0.8 + 130,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => MealCard(meal: meals[index]),
          childCount: meals.length,
        ),
      ),
    );
  }
}
