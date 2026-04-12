import 'package:flutter/material.dart';
import 'package:sucab/data/mock_rides.dart' as mockData;
import 'package:sucab/models/ride.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';

class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({super.key});

  @override
  State<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen> {
  bool isJoinedSelected = true;

  @override
  Widget build(BuildContext context) {
    final rides = isJoinedSelected ? mockData.joinedRides : mockData.createdRides;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToggleButton(
                      text: "Joined",
                      active: isJoinedSelected,
                      onTap: () => setState(() => isJoinedSelected = true),
                    ),
                    const SizedBox(width: 10),
                    _buildToggleButton(
                      text: "Created",
                      active: !isJoinedSelected,
                      onTap: () => setState(() => isJoinedSelected = false),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // CONTENT
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF5F6FA),
              child: Column(
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
                        return _RideCard(ride: ride);
                      },
                    ),
                  ),
                ],
              ),
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
class _RideCard extends StatelessWidget {
  final Ride ride;

  const _RideCard({required this.ride});

  Color _getStatusColor() {
    switch (ride.availableSeats) {
      case 3: return Colors.green;
      case 2: return Colors.blue;
      case 1: return Colors.orange;
      case 0: return Colors.red;
      default: return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => Navigator.pushNamed(
          context,
          '/ticket_detail',
          arguments: ride,
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
                      '${ride.from} → ${ride.to}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${ride.date} • ${ride.time}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${4 - ride.availableSeats}/4',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}