import 'package:flutter/material.dart';

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
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      // REDIRECTS TO GATE (LOGIN)
      Navigator.pushReplacementNamed(context, '/gate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF003366),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.airport_shuttle, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "SUCab",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            Text(
              "Ride Sharing for Sabancı",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}