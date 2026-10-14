import 'package:streetbite/domain/entities/vendor.dart';
import 'package:streetbite/domain/repositories/vendor_repository.dart';

class GetVendorsUseCase {
  const GetVendorsUseCase(this._repository);

  final VendorRepository _repository;

  List<Vendor> call() => _repository.getVendors();
}
