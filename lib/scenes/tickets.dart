import 'package:flutter/material.dart';
import 'package:sucab/Widgets/main_navigation_bar.dart';
import 'package:sucab/Widgets/notification_button.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tickets"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This is tickets"),
          NotificationButton(context),
        ],
      ),
      bottomNavigationBar: MainNavigationBar(context)
    );
  }
}