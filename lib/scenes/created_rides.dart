import 'package:flutter/material.dart';
import 'package:sucab/data/mock_rides.dart';
import 'package:sucab/models/ride.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';

class CreatedRidesScreen extends StatelessWidget {
  const CreatedRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Created Rides'),
      ),
      body: createdRides.isEmpty
          ? const Center(
              child: Text(
                'You have not created any rides yet.',
                style: TextStyle(fontSize: 16),
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
            Text('From: ${ride.from}'),
            Text('To: ${ride.to}'),
            Text('Date: ${ride.date}'),
            Text('Time: ${ride.time}'),
            Text('Available seats: ${ride.availableSeats}'),
            const SizedBox(height: 10),
            Text(
              'Passengers: ${ride.joinedUsers.isEmpty ? "No passengers yet" : ride.joinedUsers.join(", ")}',
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Edit ride button pressed'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Delete ride button pressed'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}