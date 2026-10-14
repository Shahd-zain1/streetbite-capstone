import 'package:equatable/equatable.dart';
import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/domain/payment/payment_method.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.id,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.createdAt,
  });

  final String id;
  final List<CartItem> items;
  final double total;
  final PaymentMethod paymentMethod;
  final DateTime createdAt;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props => [id, items, total, paymentMethod, createdAt];
}
