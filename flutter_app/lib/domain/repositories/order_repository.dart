import 'package:streetbite/domain/entities/order_entity.dart';

abstract interface class OrderRepository {
  Future<void> placeOrder(String userId, OrderEntity order);

  Stream<List<OrderEntity>> watchOrders(String userId);
}
