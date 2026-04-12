import 'package:flutter/material.dart';
import 'package:sucab/data/mock_rides.dart';
import 'package:sucab/data/mock_users.dart';
import 'package:sucab/models/ride.dart';
import 'package:sucab/models/user.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';

class JoinedRidesScreen extends StatelessWidget {
  const JoinedRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joined Rides'),
        backgroundColor: const Color(0xFF1E2A44),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: joinedRides.isEmpty
          ? const Center(
        child: Text(
          'You have not joined any rides yet.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: joinedRides.length,
        itemBuilder: (context, index) {
          final ride = joinedRides[index];
          return _JoinedRideCard(ride: ride);
        },
      ),
      bottomNavigationBar: MainNavigationBar(
        context,
        currentIndex: 1,
      ),
    );
  }
}

class _JoinedRideCard extends StatelessWidget {
  final Ride ride;
  const _JoinedRideCard({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + status badge
            Row(
              children: [
                Expanded(
                  child: Text(
                    ride.title,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Text(
                    ride.status,
                    style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Route
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text('${ride.from}  →  ${ride.to}',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text('${ride.date}  ·  ${ride.time}',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.event_seat_outlined,
                    size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text('${ride.availableSeats} seat(s) available',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/ticket_detail',
                    arguments: ride,
                  ),
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text('Details'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E2A44),
                    side: const BorderSide(color: Color(0xFF1E2A44)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _confirmLeave(context, ride),
                  icon: const Icon(Icons.exit_to_app, size: 16),
                  label: const Text('Leave'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLeave(BuildContext context, Ride ride) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave Ride'),
        content: Text('Are you sure you want to leave "${ride.title}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Left "${ride.title}" — coming soon!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Leave', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}