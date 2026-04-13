import 'package:flutter/material.dart';
import 'style_utils.dart'; // Ensure this import is here for AppColors

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startNavigation();
  }

  void _startNavigation() async {
    // Stays on this screen for 3 seconds before moving to Announcements
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/announcements');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF003366), // Sabanci Blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your Car/Shuttle Icon
            Icon(
              Icons.airport_shuttle, 
              size: 100, 
              color: Colors.white,
            ),
            SizedBox(height: 20),
            
            // App Title
            Text(
              "SUCab",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            
            // Tagline
            Text(
              "Ride Sharing for Sabancı",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
            
            SizedBox(height: 40),
            
            // Loading Indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}