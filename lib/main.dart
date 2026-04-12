import 'package:flutter/material.dart';
import 'scenes/tickets.dart';
import 'scenes/my_rides.dart';
import 'scenes/profile.dart';
import 'scenes/notification.dart';
import 'scenes/gate.dart';
import 'scenes/created_rides.dart';
import 'scenes/joined_rides.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUCab',
      debugShowCheckedModeBanner: false,
      initialRoute: '/tickets',
      routes: {
        '/tickets': (context) => const TicketsScreen(),
        '/my_rides': (context) => const MyRidesScreen(),
        '/created_rides': (context) => const CreatedRidesScreen(),
        '/joined_rides': (context) => const JoinedRidesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/gate': (context) => const GateScreen(),
      },
    );
  }
}