import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ride.dart';
import '../services/firestore_service.dart';

class RideProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Ride> _allRides = [];
  List<Ride> _createdRides = [];
  List<Ride> _joinedRides = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Ride> get allRides => _allRides;
  List<Ride> get createdRides => _createdRides;
  List<Ride> get joinedRides => _joinedRides;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Stream<List<Ride>> allRidesStream() => _firestoreService.allRidesStream();

  Stream<List<Ride>> createdRidesStream(String uid) =>
      _firestoreService.createdRidesStream(uid);

  Stream<List<Ride>> joinedRidesStream(String uid) =>
      _firestoreService.joinedRidesStream(uid);

  Future<bool> createRide({
    required String title,
    required String from,
    required String to,
    required String date,
    required String time,
    required int availableSeats,
    required String driverName,
    required String driverUid,
    String? preference,
    String? pickupPoint,
  }) async {
    _setLoading(true);
    try {
      final id = _firestoreService.generateId();
      final ticketId = '#SC-${DateTime.now().millisecondsSinceEpoch % 10000}';
      final ride = Ride(
        id: id,
        title: title,
        from: from,
        to: to,
        date: date,
        time: time,
        availableSeats: availableSeats,
        driverName: driverName,
        driverUid: driverUid,
        joinedUsers: [],
        status: 'Active',
        preference: preference,
        pickupPoint: pickupPoint,
        ticketId: ticketId,
        createdAt: DateTime.now(),
        createdBy: driverUid,
      );
      await _firestoreService.createRide(ride);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Ride oluşturulurken hata: $e');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> updateRide(String rideId, Map<String, dynamic> data) async {
    try {
      await _firestoreService.updateRide(rideId, data);
      return true;
    } catch (e) {
      _setError('Güncelleme hatası: $e');
      return false;
    }
  }

  Future<bool> deleteRide(String rideId) async {
    try {
      await _firestoreService.deleteRide(rideId);
      return true;
    } catch (e) {
      _setError('Silme hatası: $e');
      return false;
    }
  }

  Future<bool> joinRide(String rideId, String uid) async {
    try {
      await _firestoreService.joinRide(rideId, uid);
      return true;
    } catch (e) {
      _setError('Katılma hatası: $e');
      return false;
    }
  }

  Future<bool> leaveRide(String rideId, String uid) async {
    try {
      await _firestoreService.leaveRide(rideId, uid);
      return true;
    } catch (e) {
      _setError('Ayrılma hatası: $e');
      return false;
    }
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void _setError(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
