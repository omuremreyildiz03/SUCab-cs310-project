import '../models/ride.dart';

const String currentUserName = 'Ulukan';

final List<Ride> createdRides = [
  const Ride(
    title: 'Morning Campus Ride',
    from: 'Kadikoy',
    to: 'Sabanci University',
    date: 'April 13, 2026',
    time: '08:30',
    availableSeats: 2,
    driverName: currentUserName,
    joinedUsers: ['Ahmet', 'Zeynep'],
    status: 'Active',
    preference: 'No smoking',
    pickupPoint: 'Kadıköy Ferry',
    ticketId: '#SC-1001',
  ),
  const Ride(
    title: 'Evening Return Ride',
    from: 'Sabanci University',
    to: 'Besiktas',
    date: 'April 13, 2026',
    time: '18:15',
    availableSeats: 1,
    driverName: currentUserName,
    joinedUsers: ['Mert'],
    status: 'Active',
    pickupPoint: 'IC parking area',
    ticketId: '#SC-2541',
  ),
];

final List<Ride> joinedRides = [
  const Ride(
    title: 'Late Lecture Ride',
    from: 'Uskudar',
    to: 'Sabanci University',
    date: 'April 14, 2026',
    time: '10:00',
    availableSeats: 3,
    driverName: 'Ece',
    joinedUsers: [currentUserName, 'Ali'],
    status: 'Active',
    preference: 'No smoking',
    pickupPoint: 'Üsküdar Ferry',
    ticketId: '#SC-3012',
  ),
  const Ride(
    title: 'Weekend City Ride',
    from: 'Sabanci University',
    to: 'Taksim',
    date: 'April 15, 2026',
    time: '16:45',
    availableSeats: 2,
    driverName: 'Can',
    joinedUsers: [currentUserName, 'Selin', 'Deniz'],
    status: 'Active',
    pickupPoint: 'B6 dorm',
    ticketId: '#SC-4187',
  ),
];