import 'package:flutter/material.dart';
import 'style_utils.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final List<String> _items = [
    "Welcome to the SUCab App",
    "Don't forget to rate our app",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcements", style: AppTextStyles.heading),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          // This button allows you to move to the next part of the app
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/gate');
            },
            child: const Text(
              "PROCEED",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Card( // Required UI Component
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: const Icon(Icons.campaign, color: AppColors.primaryBlue),
              title: Text(_items[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _items.removeAt(index); // Required Dynamic Removal
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