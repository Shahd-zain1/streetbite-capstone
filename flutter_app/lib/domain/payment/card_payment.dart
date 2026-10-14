import 'package:streetbite/domain/payment/payment_processor.dart';

class CardPayment implements PaymentProcessor {
  const CardPayment();

  @override
  Future<bool> pay(double amount) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return true;
  }
}
