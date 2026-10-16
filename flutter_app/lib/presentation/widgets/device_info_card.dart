import 'package:flutter/material.dart';
import 'package:streetbite/core/services/device_info_service.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/domain/entities/device_details.dart';
import 'package:streetbite/injection.dart';

class DeviceInfoCard extends StatefulWidget {
  const DeviceInfoCard({super.key});

  @override
  State<DeviceInfoCard> createState() => _DeviceInfoCardState();
}

class _DeviceInfoCardState extends State<DeviceInfoCard> {
  late final Future<DeviceDetails> _details = getIt<DeviceInfoService>().load();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FutureBuilder<DeviceDetails>(
      future: _details,
      builder: (context, snapshot) {
        final details = snapshot.data;
        if (details == null) return const SizedBox.shrink();
        return Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: const Icon(Icons.phone_android),
            title: Text(l10n.deviceTitle),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(details.displayName),
                Text(
                  l10n.androidVersion(
                    details.androidVersion,
                    details.sdkInt.toString(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
