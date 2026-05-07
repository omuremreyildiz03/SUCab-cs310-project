import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/ride_provider.dart';
import '../models/ride.dart';
import '../widgets/main_navigation_bar.dart';

class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({super.key});

  @override
  State<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen> {
  bool isJoinedSelected = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final rideProvider = context.read<RideProvider>();
    final uid = authProvider.firebaseUser?.uid ?? '';

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF1E2A44),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            child: Column(
              children: [
                const Text('SuCab',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text('Your personal rides',
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToggleButton(
                      text: 'Joined',
                      active: isJoinedSelected,
                      onTap: () => setState(() => isJoinedSelected = true),
                    ),
                    const SizedBox(width: 10),
                    _buildToggleButton(
                      text: 'Created',
                      active: !isJoinedSelected,
                      onTap: () => setState(() => isJoinedSelected = false),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Ride>>(
              stream: isJoinedSelected
                  ? rideProvider.joinedRidesStream(uid)
                  : rideProvider.createdRidesStream(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final rides = snapshot.data ?? [];
                if (rides.isEmpty) {
                  return Center(
                    child: Text(
                      isJoinedSelected
                          ? "You haven't joined any rides yet."
                          : "You haven't created any rides yet.",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: rides.length,
                  itemBuilder: (context, index) =>
                      _RideCard(ride: rides[index]),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MainNavigationBar(currentIndex: 1),
    );
  }
}

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

class _RideCard extends StatelessWidget {
  final Ride ride;
  const _RideCard({required this.ride});

  Color _getStatusColor() {
    if (ride.availableSeats == 0) return Colors.red;
    if (ride.availableSeats == 1) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();
    // Total = availableSeats (original) + 1 (driver)
    // But availableSeats decreases as people join.
    // So: original total = joinedUsers.length + availableSeats + 1 (driver)
    final totalCapacity = ride.joinedUsers.length + ride.availableSeats + 1;
    // People currently in the car = driver (1) + joined passengers
    final currentOccupants = 1 + ride.joinedUsers.length;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => Navigator.pushNamed(context, '/ticket_detail', arguments: ride),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.2),
                child: Icon(Icons.directions_car, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${ride.from} → ${ride.to}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('${ride.date} • ${ride.time}',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$currentOccupants/$totalCapacity',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
