import 'package:streetbite/domain/entities/vendor.dart';

abstract interface class VendorRepository {
  List<Vendor> getVendors();
}
