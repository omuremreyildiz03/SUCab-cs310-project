import 'package:flutter/material.dart';
import 'package:sucab/data/mock_rides.dart';
import 'package:sucab/models/ride.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';

class JoinedRidesScreen extends StatelessWidget {
  const JoinedRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joined Rides'),
      ),
      body: joinedRides.isEmpty
          ? const Center(
              child: Text(
                'You have not joined any rides yet.',
                style: TextStyle(fontSize: 16),
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
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ride.title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Driver: ${ride.driverName}'),
            Text('From: ${ride.from}'),
            Text('To: ${ride.to}'),
            Text('Date: ${ride.date}'),
            Text('Time: ${ride.time}'),
            Text('Available seats: ${ride.availableSeats}'),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('View details button pressed'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.visibility),
                  label: const Text('Details'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Leave ride button pressed'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text('Leave'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}