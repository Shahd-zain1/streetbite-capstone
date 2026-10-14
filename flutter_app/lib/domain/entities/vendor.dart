import 'package:equatable/equatable.dart';
import 'package:streetbite/core/constants/app_constants.dart';

class Vendor extends Equatable {
  const Vendor({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.cuisineEn,
    required this.cuisineAr,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final String cuisineEn;
  final String cuisineAr;
  final double rating;
  final double latitude;
  final double longitude;

  String localizedName(String languageCode) =>
      languageCode == AppConstants.arabicCode ? nameAr : nameEn;

  String localizedCuisine(String languageCode) =>
      languageCode == AppConstants.arabicCode ? cuisineAr : cuisineEn;

  @override
  List<Object?> get props => [id];
}
