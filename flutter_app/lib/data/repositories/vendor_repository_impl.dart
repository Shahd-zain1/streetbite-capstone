import 'package:streetbite/domain/entities/vendor.dart';
import 'package:streetbite/domain/repositories/vendor_repository.dart';

class VendorRepositoryImpl implements VendorRepository {
  const VendorRepositoryImpl();

  static const _vendors = [
    Vendor(
      id: 'cairo',
      nameEn: 'Koshary El Tahrir',
      nameAr: 'كشري التحرير',
      cuisineEn: 'Egyptian street food',
      cuisineAr: 'أكل شارع مصري',
      rating: 4.7,
      latitude: 30.0444,
      longitude: 31.2357,
    ),
    Vendor(
      id: 'alexandria',
      nameEn: 'Corniche Fish Grill',
      nameAr: 'مشويات سمك الكورنيش',
      cuisineEn: 'Seafood',
      cuisineAr: 'مأكولات بحرية',
      rating: 4.5,
      latitude: 31.2001,
      longitude: 29.9187,
    ),
    Vendor(
      id: 'luxor',
      nameEn: 'Nile Falafel House',
      nameAr: 'بيت الفلافل النيلي',
      cuisineEn: 'Falafel and sandwiches',
      cuisineAr: 'فلافل وساندوتشات',
      rating: 4.4,
      latitude: 25.6872,
      longitude: 32.6396,
    ),
    Vendor(
      id: 'aswan',
      nameEn: 'Nubian Kitchen',
      nameAr: 'المطبخ النوبي',
      cuisineEn: 'Nubian home cooking',
      cuisineAr: 'أكل نوبي بيتي',
      rating: 4.8,
      latitude: 24.0889,
      longitude: 32.8998,
    ),
    Vendor(
      id: 'mansoura',
      nameEn: 'Delta Fiteer Corner',
      nameAr: 'ركن فطير الدلتا',
      cuisineEn: 'Fiteer and sweets',
      cuisineAr: 'فطير وحلويات',
      rating: 4.6,
      latitude: 31.0409,
      longitude: 31.3785,
    ),
    Vendor(
      id: 'hurghada',
      nameEn: 'Red Sea Shawarma',
      nameAr: 'شاورما البحر الأحمر',
      cuisineEn: 'Shawarma and grills',
      cuisineAr: 'شاورما ومشويات',
      rating: 4.3,
      latitude: 27.2579,
      longitude: 33.8116,
    ),
  ];

  @override
  List<Vendor> getVendors() => _vendors;
}
