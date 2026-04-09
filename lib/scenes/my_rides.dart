import 'package:flutter/material.dart';
import 'package:sucab/Widgets/main_navigation_bar.dart';
import 'package:sucab/Widgets/notification_button.dart';

class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({super.key});

  @override
  State<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Rides"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This is My Rides"),
          NotificationButton(context),
        ],
      ),
        bottomNavigationBar: MainNavigationBar(context)
    );
  }
}