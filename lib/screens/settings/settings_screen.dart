import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';

  SettingsScreen({super.key});

  final _authService = AuthService();

  Future<void> _logout(BuildContext context) async {
    await _authService.logout();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _logout(context),
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
