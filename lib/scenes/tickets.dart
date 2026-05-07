import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ride_provider.dart';
import '../models/ride.dart';
import 'style_utils.dart';
import '../widgets/main_navigation_bar.dart';
import '../widgets/notification_button.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rideProvider = context.read<RideProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('All Rides', style: AppTextStyles.heading),
        actions: const [NotificationButton()],
      ),
      body: StreamBuilder<List<Ride>>(
        stream: rideProvider.allRidesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final rides = snapshot.data ?? [];
          if (rides.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car_outlined,
                      size: 64, color: AppColors.secondaryText),
                  const SizedBox(height: 16),
                  Text('No rides yet.',
                      style: TextStyle(color: AppColors.secondaryText)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rides.length,
            itemBuilder: (context, index) => _RideCard(ride: rides[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/new_ticket'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const MainNavigationBar(currentIndex: 0),
    );
  }
}

class _RideCard extends StatelessWidget {
  final Ride ride;
  const _RideCard({required this.ride});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/ticket_detail', arguments: ride),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(ride.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${ride.availableSeats} seats',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.circle, size: 10, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(ride.from),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 14),
                const SizedBox(width: 8),
                const Icon(Icons.location_on, size: 10, color: Colors.red),
                const SizedBox(width: 4),
                Text(ride.to),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 14, color: AppColors.secondaryText),
                const SizedBox(width: 4),
                Text(ride.date,
                    style: TextStyle(
                        color: AppColors.secondaryText, fontSize: 13)),
                const SizedBox(width: 16),
                Icon(Icons.access_time,
                    size: 14, color: AppColors.secondaryText),
                const SizedBox(width: 4),
                Text(ride.time,
                    style: TextStyle(
                        color: AppColors.secondaryText, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.person, size: 14, color: AppColors.secondaryText),
                const SizedBox(width: 4),
                Text(ride.driverName,
                    style: TextStyle(
                        color: AppColors.secondaryText, fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
