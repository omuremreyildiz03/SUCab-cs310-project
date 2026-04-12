class UserProfile {
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

  const UserProfile({
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
  });
}
