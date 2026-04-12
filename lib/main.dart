import 'package:flutter/material.dart';
import 'scenes/login.dart';
import 'scenes/sign_up.dart';
import 'scenes/tickets.dart';
import 'scenes/my_rides.dart';
import 'scenes/profile.dart';
import 'scenes/notification.dart';
import 'scenes/created_rides.dart';
import 'scenes/joined_rides.dart';
import 'scenes/gate.dart';
import 'scenes/ticket_detail.dart';
import 'scenes/new_ticket.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUCab',
      initialRoute: '/gate',
      debugShowCheckedModeBanner: false,
      routes: {
        '/gate': (context) => const GateScreen(),
        '/tickets': (context) => const TicketsScreen(),
        '/my_rides': (context) => const MyRidesScreen(),
        '/created_rides': (context) => const CreatedRidesScreen(),
        '/joined_rides': (context) => const JoinedRidesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/login': (context) => const LoginScreen(),
        '/sign_up': (context) => const SignUpScreen(),
        '/ticket_detail': (context) => const TicketDetailScreen(),
        '/new_ticket': (context) => const NewTicketScreen()
      },
    );
  }
}
