import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/presentation/widgets/hot_offer_card.dart';
import 'package:streetbite/presentation/widgets/section_title.dart';

class HotOffersSection extends StatelessWidget {
  const HotOffersSection({required this.meals, super.key});

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(context.l10n.hotOffersTitle),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: meals.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, index) => HotOfferCard(meal: meals[index]),
          ),
        ),
      ],
    );
  }
}
