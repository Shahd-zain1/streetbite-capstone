part of 'cart_bloc.dart';

enum CartStatus { idle, placing, placed, failed }

class CartState extends Equatable {
  const CartState({
    this.items = const [],
    this.status = CartStatus.idle,
    this.error,
  });

  final List<CartItem> items;
  final CartStatus status;
  final ErrorKind? error;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get total => items.fold(0, (sum, item) => sum + item.total);

  @override
  List<Object?> get props => [items, status, error];
}
