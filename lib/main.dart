import 'package:flutter/material.dart';
import 'package:sucab/Scenes/gate.dart';
import 'package:sucab/Scenes/my_rides.dart';
import 'package:sucab/Scenes/profile.dart';
import 'package:sucab/Scenes/tickets.dart';

void main() {
  runApp(const SUCab());
}

class SUCab extends StatelessWidget {
  const SUCab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUCab',
      initialRoute: '/',
      routes: {
        '/gate': (context) => const GateScreen(),
        '/tickets': (context) => const TicketsScreen(),
        '/my_rides': (context) => const MyRidesScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      home: const GateScreen(),
    );
  }
}

