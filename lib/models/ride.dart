class Ride {
  final String title;
  final String from;
  final String to;
  final String date;
  final String time;
  final int availableSeats;
  final String driverName;
  final List<String> joinedUsers;

  const Ride({
    required this.title,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.availableSeats,
    required this.driverName,
    required this.joinedUsers,
  });
}