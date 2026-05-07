import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/ride_provider.dart';
import '../models/ride.dart';
import 'style_utils.dart';
import '../widgets/main_navigation_bar.dart';

class CreatedRidesScreen extends StatelessWidget {
  const CreatedRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final rideProvider = context.read<RideProvider>();
    final uid = authProvider.firebaseUser?.uid ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('My Created Rides', style: AppTextStyles.heading),
      ),
      body: StreamBuilder<List<Ride>>(
        stream: rideProvider.createdRidesStream(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final rides = snapshot.data ?? [];
          if (rides.isEmpty) {
            return Center(
              child: Text("You haven't created any rides yet.",
                  style: TextStyle(color: AppColors.secondaryText)),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rides.length,
            itemBuilder: (context, i) => _RideTile(ride: rides[i]),
          );
        },
      ),
      bottomNavigationBar: const MainNavigationBar(currentIndex: 1),
    );
  }
}

class _RideTile extends StatelessWidget {
  final Ride ride;
  const _RideTile({required this.ride});

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
            Text(ride.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Text('${ride.from} → ${ride.to}',
                style: TextStyle(color: AppColors.secondaryText)),
            const SizedBox(height: 4),
            Text('${ride.date} ${ride.time}',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 13)),
            const SizedBox(height: 4),
            Text('${ride.joinedUsers.length} people joined',
                style: TextStyle(color: AppColors.primary, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
