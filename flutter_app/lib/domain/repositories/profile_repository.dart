abstract interface class ProfileRepository {
  Stream<String?> watchPhoto(String userId);

  Future<void> updatePhoto(String userId, String photoBase64);
}
