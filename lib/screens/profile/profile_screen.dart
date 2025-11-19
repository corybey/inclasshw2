import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user.dart';
import '../../services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();

  AppUser? _appUser;
  bool _isLoading = true;
  final TextEditingController _displayNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      setState(() => _isLoading = false);
      return;
    }

    final appUser = await _userService.getUser(firebaseUser.uid);
    if (!mounted) return;
    setState(() {
      _appUser = appUser;
      _displayNameController.text = appUser?.displayName ?? '';
      _isLoading = false;
    });
  }

  Future<void> _saveDisplayName() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;

    final newName = _displayNameController.text.trim();
    if (newName.isEmpty) return;

    await _userService.updateDisplayName(firebaseUser.uid, newName);

    setState(() {
      _appUser = _appUser?.copyWith(displayName: newName);
    });
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_appUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Center(child: Text('No profile data found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${_appUser!.fullName}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Email: ${_appUser!.email}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            const Text(
              'Display Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _displayNameController,
              decoration: const InputDecoration(
                hintText: 'Enter a display name',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _saveDisplayName,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
