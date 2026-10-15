import 'package:streetbite/data/models/meal_model.dart';
import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/domain/entities/order_entity.dart';
import 'package:streetbite/domain/payment/payment_method.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.items,
    required super.total,
    required super.paymentMethod,
    required super.createdAt,
  });

  factory OrderModel.fromEntity(OrderEntity order) {
    return OrderModel(
      id: order.id,
      items: order.items,
      total: order.total,
      paymentMethod: order.paymentMethod,
      createdAt: order.createdAt,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? const [];
    return OrderModel(
      id: json['id'] as String? ?? '',
      items: rawItems.map((raw) {
        final item = raw as Map<String, dynamic>;
        return CartItem(
          meal: MealModel.fromJson(item['meal'] as Map<String, dynamic>),
          quantity: (item['quantity'] as num).toInt(),
        );
      }).toList(),
      total: (json['total'] as num).toDouble(),
      paymentMethod: PaymentMethod.values.byName(
        json['paymentMethod'] as String,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (json['createdAt'] as num).toInt(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items
          .map(
            (item) => {
              'meal': MealModel.fromEntity(item.meal).toJson(),
              'quantity': item.quantity,
            },
          )
          .toList(),
      'total': total,
      'paymentMethod': paymentMethod.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}
