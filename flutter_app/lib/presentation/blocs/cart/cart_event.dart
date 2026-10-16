part of 'cart_bloc.dart';

sealed class CartEvent {
  const CartEvent();
}

final class CartMealAdded extends CartEvent {
  const CartMealAdded(this.meal);

  final Meal meal;
}

final class CartMealRemoved extends CartEvent {
  const CartMealRemoved(this.mealId);

  final String mealId;
}

final class CartCleared extends CartEvent {
  const CartCleared();
}

final class CartOrderPlaced extends CartEvent {
  const CartOrderPlaced({required this.userId, required this.method});

  final String userId;
  final PaymentMethod method;
}
