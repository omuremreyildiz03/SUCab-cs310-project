import 'package:flutter/material.dart';
import 'package:sucab/data/mock_rides.dart';
import 'package:sucab/data/mock_users.dart';
import 'package:sucab/models/ride.dart';
import 'package:sucab/models/user.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';

class CreatedRidesScreen extends StatelessWidget {
  const CreatedRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Created Rides'),
        backgroundColor: const Color(0xFF1E2A44),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: createdRides.isEmpty
          ? const Center(
        child: Text(
          'You have not created any rides yet.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: createdRides.length,
        itemBuilder: (context, index) {
          final ride = createdRides[index];
          return _CreatedRideCard(ride: ride);
        },
      ),
      bottomNavigationBar: MainNavigationBar(
        context,
        currentIndex: 1,
      ),
    );
  }
}

class _CreatedRideCard extends StatelessWidget {
  final Ride ride;
  const _CreatedRideCard({required this.ride});

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
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Text(
                    ride.status,
                    style: TextStyle(
                        color: Colors.green.shade700,
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
            const Divider(height: 20),
            // Passengers section
            const Text('Passengers',
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 8),
            ride.joinedUsers.isEmpty
                ? const Text('No passengers yet.',
                style: TextStyle(color: Colors.grey, fontSize: 13))
                : Wrap(
              spacing: 8,
              runSpacing: 6,
              children: ride.joinedUsers.map((userName) {
                return GestureDetector(
                  onTap: () => _openUserProfile(context, userName),
                  child: Chip(
                    avatar: CircleAvatar(
                      backgroundColor: const Color(0xFF1E2A44),
                      child: Text(
                        userName[0],
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                    ),
                    label: Text(userName),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF1E2A44)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Edit ride — coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E2A44),
                    side: const BorderSide(color: Color(0xFF1E2A44)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Delete ride — coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
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

  void _openUserProfile(BuildContext context, String userName) {
    UserProfile user;
    try {
      user = otherUsers.firstWhere((u) => u.name == userName);
    } catch (_) {
      user = UserProfile(
        name: userName,
        suId: '${userName.toLowerCase()}@sabanciuniv.edu',
        faculty: 'Sabanci University',
        year: 'Unknown',
        rating: 0.0,
        totalRides: 0,
        createdRides: 0,
        joinedRides: 0,
        bio: '',
        avatarInitials: userName[0],
      );
    }
    Navigator.pushNamed(context, '/other_profile', arguments: user);
  }
}
