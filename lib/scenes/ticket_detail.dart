import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ride.dart';
import '../providers/auth_provider.dart';
import '../providers/ride_provider.dart';
import 'style_utils.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ride = ModalRoute.of(context)!.settings.arguments as Ride;
    final authProvider = context.watch<AuthProvider>();
    final rideProvider = context.watch<RideProvider>();
    final uid = authProvider.firebaseUser?.uid ?? '';
    final isDriver = ride.driverUid == uid;
    final hasJoined = ride.joinedUsers.contains(uid);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Ride Details', style: AppTextStyles.heading),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (isDriver)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Ride'),
                    content: const Text('Are you sure you want to delete this ride?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text('Cancel')),
                      TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('Delete',
                              style: TextStyle(color: Colors.red))),
                    ],
                  ),
                );
                if (confirm == true && context.mounted) {
                  await rideProvider.deleteRide(ride.id);
                  Navigator.pop(context);
                }
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ride.title,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(ride.ticketId,
                style: TextStyle(color: AppColors.secondaryText, fontSize: 13)),
            const SizedBox(height: 24),
            _DetailRow(icon: Icons.circle, label: 'From', value: ride.from),
            _DetailRow(icon: Icons.location_on, label: 'To', value: ride.to),
            _DetailRow(icon: Icons.calendar_today, label: 'Date', value: ride.date),
            _DetailRow(icon: Icons.access_time, label: 'Time', value: ride.time),
            _DetailRow(icon: Icons.person, label: 'Driver', value: ride.driverName),
            _DetailRow(
                icon: Icons.event_seat,
                label: 'Available Seats',
                value: '${ride.availableSeats}'),
            if (ride.pickupPoint != null)
              _DetailRow(
                  icon: Icons.pin_drop,
                  label: 'Pickup Point',
                  value: ride.pickupPoint!),
            if (ride.preference != null)
              _DetailRow(
                  icon: Icons.info_outline,
                  label: 'Preferences',
                  value: ride.preference!),
            const SizedBox(height: 32),
            if (!isDriver)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: rideProvider.isLoading
                      ? null
                      : () async {
                          if (hasJoined) {
                            await rideProvider.leaveRide(ride.id, uid);
                          } else {
                            if (ride.availableSeats <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('No seats available.')),
                              );
                              return;
                            }
                            await rideProvider.joinRide(ride.id, uid);
                          }
                          if (context.mounted) Navigator.pop(context);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        hasJoined ? Colors.orange : AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(hasJoined ? 'Leave' : 'Join',
                      style: const TextStyle(fontSize: 16)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      color: AppColors.secondaryText, fontSize: 12)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
