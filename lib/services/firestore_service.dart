import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ride.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ─── Collections ───────────────────────────────────────────────
  CollectionReference get _rides => _db.collection('rides');
  CollectionReference get _users => _db.collection('users');

  // ─── USER OPERATIONS ───────────────────────────────────────────

  Future<void> createUserProfile(UserProfile user) async {
    await _users.doc(user.uid).set(user.toMap());
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    final doc = await _users.doc(uid).get();
    if (doc.exists) {
      return UserProfile.fromFirestore(doc);
    }
    return null;
  }

  Stream<UserProfile?> userProfileStream(String uid) {
    return _users.doc(uid).snapshots().map((doc) {
      if (doc.exists) return UserProfile.fromFirestore(doc);
      return null;
    });
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    await _users.doc(uid).update(data);
  }

  // ─── RIDE OPERATIONS ───────────────────────────────────────────

  Future<void> createRide(Ride ride) async {
    await _rides.doc(ride.id).set(ride.toMap());
  }

  Future<void> updateRide(String rideId, Map<String, dynamic> data) async {
    await _rides.doc(rideId).update(data);
  }

  Future<void> deleteRide(String rideId) async {
    await _rides.doc(rideId).delete();
  }

  // All public rides (tickets screen)
  Stream<List<Ride>> allRidesStream() {
    return _rides
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Ride.fromFirestore(d)).toList());
  }

  // Rides created by a specific user
  Stream<List<Ride>> createdRidesStream(String uid) {
    return _rides
        .where('driverUid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Ride.fromFirestore(d)).toList());
  }

  // Rides joined by a specific user
  Stream<List<Ride>> joinedRidesStream(String uid) {
    return _rides
        .where('joinedUsers', arrayContains: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Ride.fromFirestore(d)).toList());
  }

  Future<void> joinRide(String rideId, String uid) async {
    await _rides.doc(rideId).update({
      'joinedUsers': FieldValue.arrayUnion([uid]),
      'availableSeats': FieldValue.increment(-1),
    });
  }

  Future<void> leaveRide(String rideId, String uid) async {
    await _rides.doc(rideId).update({
      'joinedUsers': FieldValue.arrayRemove([uid]),
      'availableSeats': FieldValue.increment(1),
    });
  }

  String generateId() {
    return _rides.doc().id;
  }
}
