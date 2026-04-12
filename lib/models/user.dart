class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String year;
  final String? bio;
  final double rating;
  final int completedRides;
  final String? vehicle;
  final String? vehicleColor;
  final String? vehiclePlate;
  final List<String> preferences;
  final String? profileImageUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.year,
    this.bio,
    this.rating = 4.5,
    this.completedRides = 0,
    this.vehicle,
    this.vehicleColor,
    this.vehiclePlate,
    this.preferences = const [],
    this.profileImageUrl,
  });
}
