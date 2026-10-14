import 'package:streetbite/domain/repositories/profile_repository.dart';

class WatchProfilePhotoUseCase {
  const WatchProfilePhotoUseCase(this._repository);

  final ProfileRepository _repository;

  Stream<String?> call(String userId) => _repository.watchPhoto(userId);
}
