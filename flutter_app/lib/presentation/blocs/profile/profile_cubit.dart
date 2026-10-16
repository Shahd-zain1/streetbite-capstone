import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/error_mapper.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/core/services/image_picker_service.dart';
import 'package:streetbite/domain/entities/order_entity.dart';
import 'package:streetbite/domain/usecases/update_profile_photo_use_case.dart';
import 'package:streetbite/domain/usecases/watch_orders_use_case.dart';
import 'package:streetbite/domain/usecases/watch_profile_photo_use_case.dart';
import 'package:streetbite/presentation/blocs/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._watchPhoto,
    this._watchOrders,
    this._updatePhoto,
    this._imagePicker,
  ) : super(const ProfileState());

  final WatchProfilePhotoUseCase _watchPhoto;
  final WatchOrdersUseCase _watchOrders;
  final UpdateProfilePhotoUseCase _updatePhoto;
  final ImagePickerService _imagePicker;
  StreamSubscription<String?>? _photoSubscription;
  StreamSubscription<List<OrderEntity>>? _ordersSubscription;
  String? _userId;

  void start(String userId) {
    _userId = userId;
    _photoSubscription = _watchPhoto(userId).listen(
      (photo) => emit(
        ProfileState(
          photoBase64: photo,
          orders: state.orders,
          isUploading: state.isUploading,
        ),
      ),
      onError: _onStreamError,
    );
    _ordersSubscription = _watchOrders(userId).listen(
      (orders) => emit(
        ProfileState(
          photoBase64: state.photoBase64,
          orders: orders,
          isUploading: state.isUploading,
        ),
      ),
      onError: _onStreamError,
    );
  }

  void _onStreamError(Object error) {
    emit(
      ProfileState(
        photoBase64: state.photoBase64,
        orders: state.orders,
        isUploading: state.isUploading,
        error: ErrorMapper.map(error).kind,
      ),
    );
  }

  Future<Failure?> changePhoto() async {
    try {
      final photo = await _imagePicker.pickBase64();
      if (photo == null) return null;
      _emitUploading(true);
      await _updatePhoto(_userId!, photo);
      _emitUploading(false);
      return null;
    } catch (error) {
      _emitUploading(false);
      return ErrorMapper.map(error);
    }
  }

  void _emitUploading(bool isUploading) {
    if (isClosed) return;
    emit(
      ProfileState(
        photoBase64: state.photoBase64,
        orders: state.orders,
        isUploading: isUploading,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _photoSubscription?.cancel();
    await _ordersSubscription?.cancel();
    return super.close();
  }
}
