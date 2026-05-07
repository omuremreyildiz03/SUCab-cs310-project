import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String name;
  final String suId;
  final String faculty;
  final String year;
  final double rating;
  final int totalRides;
  final int createdRides;
  final int joinedRides;
  final String bio;
  final String? avatarInitials;
  final DateTime createdAt;
  final String createdBy;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.suId,
    required this.faculty,
    required this.year,
    required this.rating,
    required this.totalRides,
    required this.createdRides,
    required this.joinedRides,
    required this.bio,
    this.avatarInitials,
    required this.createdAt,
    required this.createdBy,
  });

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      uid: doc.id,
      name: data['name'] ?? '',
      suId: data['suId'] ?? '',
      faculty: data['faculty'] ?? '',
      year: data['year'] ?? '',
      rating: (data['rating'] ?? 5.0).toDouble(),
      totalRides: data['totalRides'] ?? 0,
      createdRides: data['createdRides'] ?? 0,
      joinedRides: data['joinedRides'] ?? 0,
      bio: data['bio'] ?? '',
      avatarInitials: data['avatarInitials'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: data['createdBy'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'suId': suId,
      'faculty': faculty,
      'year': year,
      'rating': rating,
      'totalRides': totalRides,
      'createdRides': createdRides,
      'joinedRides': joinedRides,
      'bio': bio,
      'avatarInitials': avatarInitials,
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': createdBy,
    };
  }

  UserProfile copyWith({
    String? uid,
    String? name,
    String? suId,
    String? faculty,
    String? year,
    double? rating,
    int? totalRides,
    int? createdRides,
    int? joinedRides,
    String? bio,
    String? avatarInitials,
    DateTime? createdAt,
    String? createdBy,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      suId: suId ?? this.suId,
      faculty: faculty ?? this.faculty,
      year: year ?? this.year,
      rating: rating ?? this.rating,
      totalRides: totalRides ?? this.totalRides,
      createdRides: createdRides ?? this.createdRides,
      joinedRides: joinedRides ?? this.joinedRides,
      bio: bio ?? this.bio,
      avatarInitials: avatarInitials ?? this.avatarInitials,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
