import 'package:flutter/material.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';

class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({super.key});

  @override
  State<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen> {
  bool isJoinedSelected = true;

  // 🔹 MOCK DATA
  final List<Map<String, dynamic>> joinedRides = [
    {
      "route": "Kadıköy → Sabiha Gökçen",
      "time": "Today • 2:30 PM",
      "seats": "1/4",
      "color": Colors.green,
    },
    {
      "route": "Campus → Sabiha Gökçen",
      "time": "Today • 3:00 PM",
      "seats": "3/4",
      "color": Colors.orange,
    },
  ];

  final List<Map<String, dynamic>> createdRides = [
    {
      "route": "Campus → Kadıköy",
      "time": "Today • 1:00 PM",
      "seats": "1/4",
      "color": Colors.green,
    },
    {
      "route": "Taksim → Kadıköy",
      "time": "Today • 5:00 PM",
      "seats": "3/4",
      "color": Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF1E2A44),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "SuCab",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Your personal rides",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 14),

                // TOGGLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToggleButton(
                      text: "Joined",
                      active: isJoinedSelected,
                      onTap: () {
                        setState(() {
                          isJoinedSelected = true;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildToggleButton(
                      text: "Created",
                      active: !isJoinedSelected,
                      onTap: () {
                        setState(() {
                          isJoinedSelected = false;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),

          // CONTENT
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F6FA),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: _buildContent(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainNavigationBar(
        context,
        currentIndex: 1,
      ),
    );
  }

  // CONTENT BUILDER
  Widget _buildContent() {
    final rides = isJoinedSelected ? joinedRides : createdRides;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ACTIVE",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 12),

        Expanded(
          child: rides.isEmpty
              ? Center(
                  child: Text(
                    isJoinedSelected
                        ? "You haven't joined any rides yet."
                        : "You haven't created any rides yet.",
                    style: const TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: rides.length,
                  itemBuilder: (context, index) {
                    final ride = rides[index];
                    return RideCard(
                      route: ride["route"],
                      time: ride["time"],
                      seats: ride["seats"],
                      color: ride["color"],
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// TOGGLE BUTTON
Widget _buildToggleButton({
  required String text,
  required bool active,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// RIDE CARD
class RideCard extends StatelessWidget {
  final String route;
  final String time;
  final String seats;
  final Color color;

  const RideCard({
    super.key,
    required this.route,
    required this.time,
    required this.seats,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(Icons.directions_car, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    route,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                seats,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}