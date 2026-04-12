import 'package:flutter/material.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';
import 'package:sucab/widgets/notification_button.dart';

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
        title: const Text("My Profile"),
        actions: [
          NotificationButton(context),
        ],
      ),
      body: const Center(
        child: Text("This is my profile"),
      ),
      bottomNavigationBar: MainNavigationBar(
        context,
        currentIndex: 2,
      ),
    );
  }
}