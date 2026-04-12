import 'package:flutter/material.dart';

Widget MainNavigationBar(
  BuildContext context, {
  required int currentIndex,
}) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) {
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/tickets');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/my_rides');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/profile');
          break;
      }
    },
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.airplane_ticket),
        label: 'Tickets',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.car_rental),
        label: 'My Rides',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
  );
}