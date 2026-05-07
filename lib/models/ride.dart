import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  final String id;
  final String title;
  final String from;
  final String to;
  final String date;
  final String time;
  final int availableSeats;
  final String driverName;
  final String driverUid;
  final List<String> joinedUsers;
  final String status;
  final String? preference;
  final String? pickupPoint;
  final String ticketId;
  final DateTime createdAt;
  final String createdBy;

  const Ride({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.availableSeats,
    required this.driverName,
    required this.driverUid,
    required this.joinedUsers,
    required this.status,
    this.preference,
    this.pickupPoint,
    required this.ticketId,
    required this.createdAt,
    required this.createdBy,
  });

  factory Ride.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Ride(
      id: doc.id,
      title: data['title'] ?? '',
      from: data['from'] ?? '',
      to: data['to'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      availableSeats: data['availableSeats'] ?? 0,
      driverName: data['driverName'] ?? '',
      driverUid: data['driverUid'] ?? '',
      joinedUsers: List<String>.from(data['joinedUsers'] ?? []),
      status: data['status'] ?? 'Active',
      preference: data['preference'],
      pickupPoint: data['pickupPoint'],
      ticketId: data['ticketId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: data['createdBy'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'from': from,
      'to': to,
      'date': date,
      'time': time,
      'availableSeats': availableSeats,
      'driverName': driverName,
      'driverUid': driverUid,
      'joinedUsers': joinedUsers,
      'status': status,
      'preference': preference,
      'pickupPoint': pickupPoint,
      'ticketId': ticketId,
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': createdBy,
    };
  }

  Ride copyWith({
    String? id,
    String? title,
    String? from,
    String? to,
    String? date,
    String? time,
    int? availableSeats,
    String? driverName,
    String? driverUid,
    List<String>? joinedUsers,
    String? status,
    String? preference,
    String? pickupPoint,
    String? ticketId,
    DateTime? createdAt,
    String? createdBy,
  }) {
    return Ride(
      id: id ?? this.id,
      title: title ?? this.title,
      from: from ?? this.from,
      to: to ?? this.to,
      date: date ?? this.date,
      time: time ?? this.time,
      availableSeats: availableSeats ?? this.availableSeats,
      driverName: driverName ?? this.driverName,
      driverUid: driverUid ?? this.driverUid,
      joinedUsers: joinedUsers ?? this.joinedUsers,
      status: status ?? this.status,
      preference: preference ?? this.preference,
      pickupPoint: pickupPoint ?? this.pickupPoint,
      ticketId: ticketId ?? this.ticketId,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
