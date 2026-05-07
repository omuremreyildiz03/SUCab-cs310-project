import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/ride_provider.dart';
import 'providers/user_provider.dart';
import 'scenes/auth_gate.dart';
import 'scenes/login.dart';
import 'scenes/sign_up.dart';
import 'scenes/tickets.dart';
import 'scenes/my_rides.dart';
import 'scenes/profile.dart';
import 'scenes/notification.dart';
import 'scenes/created_rides.dart';
import 'scenes/joined_rides.dart';
import 'scenes/gate.dart';
import 'scenes/ticket_detail.dart';
import 'scenes/new_ticket.dart';
import 'scenes/other_profile.dart';
import 'scenes/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RideProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'SUCab',
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/auth': (context) => const AuthGate(),
          '/gate': (context) => const GateScreen(),
          '/tickets': (context) => const TicketsScreen(),
          '/my_rides': (context) => const MyRidesScreen(),
          '/created_rides': (context) => const CreatedRidesScreen(),
          '/joined_rides': (context) => const JoinedRidesScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/notification': (context) => const NotificationScreen(),
          '/login': (context) => const LoginScreen(),
          '/sign_up': (context) => const SignUpScreen(),
          '/ticket_detail': (context) => const TicketDetailScreen(),
          '/new_ticket': (context) => const NewTicketScreen(),
          '/other_profile': (context) => const OtherProfileScreen(),
        },
      ),
    );
  }
}
