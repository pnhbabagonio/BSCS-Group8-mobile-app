import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:psits_app/presentation/pages/auth/login_screen.dart';
import 'package:psits_app/presentation/pages/auth/registration_screen.dart';
import 'package:psits_app/presentation/pages/home/home_screen.dart';
import 'package:psits_app/presentation/pages/events/events_screen.dart';
import 'package:psits_app/presentation/pages/payments/payments_screen.dart';
import 'package:psits_app/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PSITS NEXUS',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/home': (context) => const HomeScreen(),
        '/events': (context) => const EventsScreen(),
        '/payments': (context) => const PaymentsScreen(),
      },
    );
  }
}