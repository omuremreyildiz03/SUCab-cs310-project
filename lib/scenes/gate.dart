import 'package:flutter/material.dart';
import 'package:sucab/data/mock_rides.dart';

class GateScreen extends StatefulWidget {
  const GateScreen({super.key});

  @override
  State<GateScreen> createState() => _GateScreenState();
}

class _GateScreenState extends State<GateScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 100, 100, 200),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Text("SuCab", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/sign_up'),
                icon: Icon(Icons.person_add),
                label: Text("Sign up"),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                icon: Icon(Icons.login),
                label: Text("Login"),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/ticket_detail',
                  arguments: createdRides[0],
                ),
                icon: Icon(Icons.confirmation_number),
                label: Text("Test Ticket Detail"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
