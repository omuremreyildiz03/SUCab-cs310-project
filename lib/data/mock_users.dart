import '../models/user.dart';

final User currentUser = User(
  id: 'u001',
  name: 'Ulukan',
  email: 'ulukan@student.sabanciuniv.edu',
  phone: '+90 (555) 123-4567',
  department: 'Engineering',
  year: '3rd Year',
  bio: 'Friendly and punctual driver. Enjoy good music and conversations!',
  rating: 4.8,
  completedRides: 24,
  vehicle: 'Tesla Model 3',
  vehicleColor: 'Pearl White Multi-Coat',
  vehiclePlate: '34-ABC-5678',
  preferences: ['No smoking', 'AC preferred', 'Quiet environment'],
);

final Map<String, User> otherUsers = {
  'Ece': User(
    id: 'u002',
    name: 'Ece',
    email: 'ece@student.sabanciuniv.edu',
    phone: '+90 (555) 234-5678',
    department: 'Business',
    year: '2nd Year',
    bio: 'Safe driver, always on time. Let\'s carpool together!',
    rating: 4.7,
    completedRides: 18,
    vehicle: 'Toyota Corolla',
    vehicleColor: 'Silver',
    vehiclePlate: '34-XYZ-9012',
    preferences: ['Music allowed', 'Chat friendly', 'Professional'],
  ),
  'Can': User(
    id: 'u003',
    name: 'Can',
    email: 'can@student.sabanciuniv.edu',
    phone: '+90 (555) 345-6789',
    department: 'Computer Science',
    year: '4th Year',
    bio: 'Tech enthusiast looking for reliable travel companions.',
    rating: 4.6,
    completedRides: 31,
    vehicle: 'Honda Civic',
    vehicleColor: 'Black',
    vehiclePlate: '34-DEF-3456',
    preferences: ['Tech podcasts', 'No smoking'],
  ),
};

User getUserByName(String driverName) {
  return otherUsers[driverName] ??
      User(
        id: 'u_unknown',
        name: driverName,
        email: '$driverName@student.sabanciuniv.edu',
        phone: '+90 (555) 999-9999',
        department: 'Unknown',
        year: '3rd Year',
        bio: 'Reliable driver',
        rating: 4.5,
        completedRides: 0,
      );
}
