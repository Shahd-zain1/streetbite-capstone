import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/error_kind.dart';
import 'package:streetbite/core/errors/error_mapper.dart';
import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/payment/payment_method.dart';
import 'package:streetbite/domain/usecases/place_order_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._placeOrder) : super(const CartState()) {
    on<CartMealAdded>(_onMealAdded);
    on<CartMealRemoved>(_onMealRemoved);
    on<CartCleared>((event, emit) => emit(const CartState()));
    on<CartOrderPlaced>(_onOrderPlaced);
  }

  final PlaceOrderUseCase _placeOrder;

  void _onMealAdded(CartMealAdded event, Emitter<CartState> emit) {
    final items = [...state.items];
    final index = items.indexWhere((item) => item.meal.id == event.meal.id);
    if (index == -1) {
      items.add(CartItem(meal: event.meal, quantity: 1));
    } else {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    }
    emit(CartState(items: items));
  }

  void _onMealRemoved(CartMealRemoved event, Emitter<CartState> emit) {
    emit(
      CartState(
        items: state.items
            .where((item) => item.meal.id != event.mealId)
            .toList(),
      ),
    );
  }

  Future<void> _onOrderPlaced(
    CartOrderPlaced event,
    Emitter<CartState> emit,
  ) async {
    final items = state.items;
    if (items.isEmpty || state.status == CartStatus.placing) return;
    emit(CartState(items: items, status: CartStatus.placing));
    try {
      await _placeOrder(
        userId: event.userId,
        items: items,
        method: event.method,
      );
      emit(const CartState(status: CartStatus.placed));
    } catch (error) {
      emit(
        CartState(
          items: items,
          status: CartStatus.failed,
          error: ErrorMapper.map(error).kind,
        ),
      );
    }
  }
}
