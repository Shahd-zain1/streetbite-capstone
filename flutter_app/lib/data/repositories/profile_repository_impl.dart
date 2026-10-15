import 'package:streetbite/data/datasources/firestore_service.dart';
import 'package:streetbite/data/models/user_model.dart';
import 'package:streetbite/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._firestore);

  final FirestoreService _firestore;

  @override
  Stream<String?> watchPhoto(String userId) {
    return _firestore.watchUser(userId).map((data) {
      if (data == null) return null;
      return UserModel.fromJson({...data, 'uid': userId}).photoBase64;
    });
  }

  @override
  Future<void> updatePhoto(String userId, String photoBase64) {
    return _firestore.mergeUser(userId, {'photoBase64': photoBase64});
  }
}
