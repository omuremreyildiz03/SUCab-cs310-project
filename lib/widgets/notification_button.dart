import 'package:flutter/material.dart';

Widget NotificationButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.pushNamed(context, '/notification');
    },
    icon: const Icon(Icons.notifications),
  );
}