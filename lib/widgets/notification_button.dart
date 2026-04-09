import 'package:flutter/material.dart';

Widget NotificationButton (BuildContext context) {
  return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/notification');
      },
    child: Icon(Icons.notifications),
  );
}