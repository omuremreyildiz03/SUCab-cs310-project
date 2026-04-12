import 'package:flutter/material.dart';
import 'package:sucab/data/mock_users.dart';
import 'package:sucab/models/user.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';
import 'package:sucab/widgets/notification_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfile user = currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xFF1E2A44),
        foregroundColor: Colors.white,
        actions: [
          NotificationButton(context),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildStats(),
            _buildBio(),
            _buildActions(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigationBar(
        context,
        currentIndex: 2,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF1E2A44),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white24,
                child: Text(
                  user.avatarInitials ?? user.name[0],
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Photo upload coming soon!')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt,
                      size: 16, color: Color(0xFF1E2A44)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.suId,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, color: Colors.white54, size: 14),
              const SizedBox(width: 4),
              Text(
                '${user.faculty} · ${user.year}',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildRatingBadge(user.rating),
        ],
      ),
    );
  }

  Widget _buildRatingBadge(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
          const SizedBox(width: 5),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(width: 4),
          const Text('rating',
              style: TextStyle(color: Colors.white60, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        children: [
          _buildStatCard(
              'Total Rides', user.totalRides.toString(), Icons.directions_car),
          const SizedBox(width: 10),
          _buildStatCard(
              'Created', user.createdRides.toString(), Icons.add_circle_outline),
          const SizedBox(width: 10),
          _buildStatCard('Joined', user.joinedRides.toString(), Icons.group),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF1E2A44), size: 22),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E2A44))),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildBio() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('About Me',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                GestureDetector(
                  onTap: _showEditBioDialog,
                  child: const Icon(Icons.edit_outlined,
                      size: 18, color: Color(0xFF1E2A44)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(user.bio,
                style: const TextStyle(color: Colors.black87, height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          children: [
            _buildActionRow(
              icon: Icons.edit,
              label: 'Edit Profile',
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Profile coming soon!')),
              ),
            ),
            const Divider(height: 1, indent: 56),
            _buildActionRow(
              icon: Icons.history,
              label: 'Ride History',
              onTap: () => Navigator.pushNamed(context, '/my_rides'),
            ),
            const Divider(height: 1, indent: 56),
            _buildActionRow(
              icon: Icons.logout,
              label: 'Log Out',
              color: Colors.red,
              onTap: _confirmLogout,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    final c = color ?? const Color(0xFF1E2A44);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: c, size: 22),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: TextStyle(color: c, fontSize: 15))),
            Icon(Icons.chevron_right, color: c.withOpacity(0.5), size: 20),
          ],
        ),
      ),
    );
  }

  void _showEditBioDialog() {
    final controller = TextEditingController(text: user.bio);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Bio'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Tell others about yourself...',
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bio updated!')),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2A44)),
            child:
            const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacementNamed(context, '/gate');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
            const Text('Log Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
