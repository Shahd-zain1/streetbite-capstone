import 'package:equatable/equatable.dart';
import 'package:streetbite/core/errors/error_kind.dart';
import 'package:streetbite/domain/entities/order_entity.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.photoBase64,
    this.orders = const [],
    this.isUploading = false,
    this.error,
  });

  final String? photoBase64;
  final List<OrderEntity> orders;
  final bool isUploading;
  final ErrorKind? error;

  @override
  List<Object?> get props => [photoBase64, orders, isUploading, error];
}
