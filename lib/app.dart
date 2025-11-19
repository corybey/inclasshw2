// lib/app.dart
import 'package:flutter/material.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/boards_home_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'models/board.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HW2 Message Board',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        BoardsHomeScreen.routeName: (_) => const BoardsHomeScreen(),
        ProfileScreen.routeName: (_) => const ProfileScreen(),
        SettingsScreen.routeName: (_) => SettingsScreen(),
      },
      // board argument for chat
      onGenerateRoute: (settings) {
        if (settings.name == ChatScreen.routeName) {
          final board = settings.arguments as Board;
          return MaterialPageRoute(
            builder: (_) => ChatScreen(board: board),
          );
        }
        return null;
      },
    );
  }
}
