import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/domain/usecases/get_vendors_use_case.dart';
import 'package:streetbite/injection.dart';

class VendorMapScreen extends StatelessWidget {
  const VendorMapScreen({super.key});

  static const _egyptCenter = CameraPosition(
    target: LatLng(27.0, 30.8),
    zoom: 5.2,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final markers = getIt<GetVendorsUseCase>()()
        .map(
          (vendor) => Marker(
            markerId: MarkerId(vendor.id),
            position: LatLng(vendor.latitude, vendor.longitude),
            infoWindow: InfoWindow(
              title: vendor.localizedName(languageCode),
              snippet: l10n.vendorSnippet(
                vendor.localizedCuisine(languageCode),
                vendor.rating,
              ),
            ),
          ),
        )
        .toSet();
    return GoogleMap(initialCameraPosition: _egyptCenter, markers: markers);
  }
}
