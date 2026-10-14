import 'package:streetbite/domain/entities/order_entity.dart';
import 'package:streetbite/domain/repositories/order_repository.dart';

class WatchOrdersUseCase {
  const WatchOrdersUseCase(this._repository);

  final OrderRepository _repository;

  Stream<List<OrderEntity>> call(String userId) =>
      _repository.watchOrders(userId);
}
