import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  User? _firebaseUser;
  UserProfile? _userProfile;
  bool _isLoading = true;
  String? _errorMessage;

  User? get firebaseUser => _firebaseUser;
  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _firebaseUser != null;

  AuthProvider() {
    _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) async {
    _firebaseUser = user;
    if (user != null) {
      _userProfile = await _firestoreService.getUserProfile(user.uid);
    } else {
      _userProfile = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
    required String faculty,
    required String year,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      final cred = await _authService.signUp(email: email, password: password);
      final uid = cred.user!.uid;
      final initials = name.isNotEmpty ? name[0].toUpperCase() : '?';
      final profile = UserProfile(
        uid: uid,
        name: name,
        suId: email,
        faculty: faculty,
        year: year,
        rating: 5.0,
        totalRides: 0,
        createdRides: 0,
        joinedRides: 0,
        bio: '',
        avatarInitials: initials,
        createdAt: DateTime.now(),
        createdBy: uid,
      );
      await _firestoreService.createUserProfile(profile);
      _userProfile = profile;
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setError(_authService.getErrorMessage(e.code));
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.signIn(email: email, password: password);
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setError(_authService.getErrorMessage(e.code));
      _setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void _setError(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() => _clearError();
}