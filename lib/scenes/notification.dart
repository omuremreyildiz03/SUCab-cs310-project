import 'package:flutter/material.dart';
import 'style_utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<String> _notifications = [
    "Welcome to SUCab Notifications",
    "Don't forget to rate our app",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications", style: AppTextStyles.heading),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        // PROCEED BUTTON REMOVED
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          return Card( // Required UI Component
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.notifications_active, color: AppColors.primaryBlue),
              title: Text(_notifications[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _notifications.removeAt(index); // Required Dynamic Removal
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}