import 'package:streetbite/domain/repositories/profile_repository.dart';

class UpdateProfilePhotoUseCase {
  const UpdateProfilePhotoUseCase(this._repository);

  final ProfileRepository _repository;

  Future<void> call(String userId, String photoBase64) =>
      _repository.updatePhoto(userId, photoBase64);
}
