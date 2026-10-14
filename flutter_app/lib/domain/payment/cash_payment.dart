import 'package:streetbite/domain/payment/payment_processor.dart';

class CashPayment implements PaymentProcessor {
  const CashPayment();

  @override
  Future<bool> pay(double amount) async => true;
}
