import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streetbite/core/constants/app_constants.dart';

// Singleton Pattern: one shared instance is the only door to Firestore, so
// collection names and write options live in a single place.
class FirestoreService {
  FirestoreService._();

  static final FirestoreService instance = FirestoreService._();

  factory FirestoreService() => instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _userDoc(String userId) =>
      _db.collection(AppConstants.usersCollection).doc(userId);

  Future<void> mergeUser(String userId, Map<String, dynamic> data) {
    return _userDoc(userId).set(data, SetOptions(merge: true));
  }

  Stream<Map<String, dynamic>?> watchUser(String userId) {
    return _userDoc(userId).snapshots().map((snapshot) => snapshot.data());
  }

  Future<void> addOrder(String userId, Map<String, dynamic> data) async {
    await _userDoc(userId).collection(AppConstants.ordersCollection).add(data);
  }

  Stream<List<Map<String, dynamic>>> watchOrders(String userId) {
    return _userDoc(userId)
        .collection(AppConstants.ordersCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => {...doc.data(), 'id': doc.id})
              .toList(),
        );
  }
}
