import 'package:equatable/equatable.dart';

class DeviceDetails extends Equatable {
  const DeviceDetails({
    required this.manufacturer,
    required this.model,
    required this.androidVersion,
    required this.sdkInt,
  });

  final String manufacturer;
  final String model;
  final String androidVersion;
  final int sdkInt;

  String get displayName => '$manufacturer $model';

  @override
  List<Object?> get props => [manufacturer, model, androidVersion, sdkInt];
}
