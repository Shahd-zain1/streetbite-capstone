import 'package:flutter/material.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/presentation/screens/meal_details_screen.dart';
import 'package:streetbite/presentation/screens/sign_up_screen.dart';

class AppRouter {
  AppRouter._();

  static const signUp = '/sign-up';
  static const mealDetails = '/meal-details';

  static Route<void>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const SignUpScreen(),
        );
      case mealDetails:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => MealDetailsScreen(meal: settings.arguments! as Meal),
        );
    }
    return null;
  }

  static Future<void> openMeal(BuildContext context, Meal meal) {
    return Navigator.of(context).pushNamed(mealDetails, arguments: meal);
  }
}
