import 'package:flutter/material.dart';
import 'package:sucab/models/ride.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ride = ModalRoute.of(context)!.settings.arguments as Ride;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(ride),
            _buildDetails(ride),
            _buildCompanions(ride),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigationBar(
        context,
        currentIndex: 0,
      ),
    );
  }

  Widget _buildHeader(Ride ride) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF1E2A44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${ride.from} → ${ride.to}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${ride.date} • ${ride.time}',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              ride.status,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDetails(Ride ride) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('DETAILS', style: TextStyle(fontWeight: FontWeight.bold)),
              const Divider(),
              _buildDetailRow('Status', ride.status),
              _buildDetailRow('Available Seats', '${ride.availableSeats} / 4'),
              _buildDetailRow('Pickup Point', ride.pickupPoint ?? 'Not specified'),
              _buildDetailRow('Preference', ride.preference ?? 'None'),
              _buildDetailRow('Ticket ID', ride.ticketId),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCompanions(Ride ride) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('COMPANIONS', style: TextStyle(fontWeight: FontWeight.bold)),
              const Divider(),
              ...ride.joinedUsers.map((user) => ListTile(
                leading: CircleAvatar(child: Text(user[0])),
                title: Text(user),
              )),
            ],
          ),
        ),
      ),
    );
  }
}