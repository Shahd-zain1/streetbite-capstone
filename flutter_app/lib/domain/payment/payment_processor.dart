// SOLID: the order flow depends on this abstraction only (Dependency
// Inversion). New payment types are added as new classes without touching
// PlaceOrderUseCase (Open/Closed).
abstract interface class PaymentProcessor {
  Future<bool> pay(double amount);
}
