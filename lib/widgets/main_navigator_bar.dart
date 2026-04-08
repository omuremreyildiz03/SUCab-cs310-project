import 'package:flutter/material.dart';

Widget MainNavigationBar(BuildContext context){

  return BottomNavigationBar(
    currentIndex: 0,
    onTap: (index) {
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/tickets');
          break;
        case 1:
          Navigator.pushNamed(context, '/my_rides');
          break;
        case 2:
          Navigator.pushNamed(context, '/profile');
          break;
      }
    },
    items: [
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
