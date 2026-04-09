import 'package:flutter/material.dart';
import 'package:sucab/Widgets/main_navigation_bar.dart';
import 'package:sucab/Widgets/notification_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This is my profile"),
          NotificationButton(context),
        ],
      ),
        bottomNavigationBar: MainNavigationBar(context)
    );
  }
}