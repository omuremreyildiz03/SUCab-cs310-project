import 'package:flutter/material.dart';
import 'package:sucab/scenes/login.dart';
import 'package:sucab/scenes/sign_up.dart';
import 'scenes/tickets.dart';
import 'scenes/my_rides.dart';
import 'scenes/profile.dart';
import 'scenes/notification.dart';
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
      initialRoute: '/gate',
      debugShowCheckedModeBanner: false,
      routes: {
        '/tickets': (context) => const TicketsScreen(),
        '/my_rides': (context) => const MyRidesScreen(),
        '/created_rides': (context) => const CreatedRidesScreen(),
        '/joined_rides': (context) => const JoinedRidesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/login': (context) => const LoginScreen(),
        '/sign_up': (context) => const SignUpScreen()
      },
    );
  }
}
