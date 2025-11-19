import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: user == null
            ? const Text('No user logged in.')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('UID: ${user.uid}'),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email ?? 'N/A'}'),
                ],
              ),
      ),
    );
  }
}
