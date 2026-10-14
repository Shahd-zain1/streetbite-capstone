import 'package:streetbite/core/errors/error_kind.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/domain/entities/order_entity.dart';
import 'package:streetbite/domain/payment/payment_method.dart';
import 'package:streetbite/domain/payment/payment_processor.dart';
import 'package:streetbite/domain/repositories/order_repository.dart';

class PlaceOrderUseCase {
  const PlaceOrderUseCase(this._repository, this._processors);

  final OrderRepository _repository;
  final Map<PaymentMethod, PaymentProcessor> _processors;

  Future<void> call({
    required String userId,
    required List<CartItem> items,
    required PaymentMethod method,
  }) async {
    final total = items.fold<double>(0, (sum, item) => sum + item.total);
    final processor = _processors[method];
    if (processor == null || !await processor.pay(total)) {
      throw const Failure(ErrorKind.paymentFailed);
    }
    await _repository.placeOrder(
      userId,
      OrderEntity(
        id: '',
        items: items,
        total: total,
        paymentMethod: method,
        createdAt: DateTime.now(),
      ),
    );
  }
}
