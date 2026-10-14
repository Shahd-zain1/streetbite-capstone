import 'package:streetbite/domain/entities/app_user.dart';
import 'package:streetbite/domain/repositories/auth_repository.dart';

class ObserveAuthStateUseCase {
  const ObserveAuthStateUseCase(this._repository);

  final AuthRepository _repository;

  Stream<AppUser?> call() => _repository.authChanges;
}
