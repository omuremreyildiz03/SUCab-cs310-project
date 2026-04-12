import 'scenes/tickets.dart';
import 'scenes/my_rides.dart';
import 'scenes/profile.dart';
import 'scenes/other_profile.dart';
import 'scenes/notification.dart';
import 'scenes/created_rides.dart';
import 'scenes/joined_rides.dart';
        '/login': (context) => const LoginScreen(),
        '/sign_up': (context) => const SignUpScreen()
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/other_profile') {
          final arguments = settings.arguments;
          final profile = arguments is Map
              ? arguments.map(
                  (key, value) => MapEntry(
                    key.toString(),
                    value.toString(),
                  ),
                )
              : null;

          return MaterialPageRoute(
            builder: (context) => OtherProfileScreen(profile: profile),
          );
        }

        return null;
      },
    );
  }
}
