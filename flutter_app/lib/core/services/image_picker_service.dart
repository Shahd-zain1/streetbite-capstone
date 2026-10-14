import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:streetbite/core/constants/app_constants.dart';

class ImagePickerService {
  const ImagePickerService(this._picker);

  final ImagePicker _picker;

  Future<String?> pickBase64() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: AppConstants.photoMaxSize,
      maxHeight: AppConstants.photoMaxSize,
      imageQuality: AppConstants.photoQuality,
    );
    if (file == null) return null;
    return base64Encode(await file.readAsBytes());
  }
}
