import 'package:streetbite/data/datasources/firestore_service.dart';
import 'package:streetbite/data/models/order_model.dart';
import 'package:streetbite/domain/entities/order_entity.dart';
import 'package:streetbite/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl(this._firestore);

  final FirestoreService _firestore;

  @override
  Future<void> placeOrder(String userId, OrderEntity order) {
    return _firestore.addOrder(userId, OrderModel.fromEntity(order).toJson());
  }

  @override
  Stream<List<OrderEntity>> watchOrders(String userId) {
    return _firestore
        .watchOrders(userId)
        .map((docs) => docs.map(OrderModel.fromJson).toList());
  }
}
