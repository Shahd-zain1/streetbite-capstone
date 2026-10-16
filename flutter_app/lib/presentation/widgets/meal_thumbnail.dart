import 'package:flutter/material.dart';
import 'package:streetbite/presentation/widgets/meal_image.dart';

class MealThumbnail extends StatelessWidget {
  const MealThumbnail({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 56,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: MealImage(url: url),
      ),
    );
  }
}
