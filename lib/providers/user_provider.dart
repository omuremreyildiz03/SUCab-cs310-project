import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/firestore_service.dart';

class UserProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  UserProfile? _userProfile;
  bool _isLoading = false;

  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;

  Stream<UserProfile?> userProfileStream(String uid) =>
      _firestoreService.userProfileStream(uid);

  Future<void> loadUserProfile(String uid) async {
    _isLoading = true;
    notifyListeners();
    _userProfile = await _firestoreService.getUserProfile(uid);
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _firestoreService.updateUserProfile(uid, data);
      _userProfile = await _firestoreService.getUserProfile(uid);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void clearProfile() {
    _userProfile = null;
    notifyListeners();
  }
}
