import 'package:device_info_plus/device_info_plus.dart';
import 'package:streetbite/domain/entities/device_details.dart';

class DeviceInfoService {
  const DeviceInfoService(this._plugin);

  final DeviceInfoPlugin _plugin;

  Future<DeviceDetails> load() async {
    final info = await _plugin.androidInfo;
    return DeviceDetails(
      manufacturer: _capitalize(info.manufacturer),
      model: info.model,
      androidVersion: info.version.release,
      sdkInt: info.version.sdkInt,
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}
