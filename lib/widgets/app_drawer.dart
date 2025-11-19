import 'package:flutter/material.dart';

import '../screens/home/boards_home_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/settings_screen.dart';
// Drawer widget that provides navigation to main sections of the app
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          //go to message board
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Message Boards'),
            onTap: () {
              Navigator.pushNamed(
                  context, BoardsHomeScreen.routeName);
            },
          ),
          //go to profile
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                  context, ProfileScreen.routeName);
            },
          ),
          //go to settings
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(
                  context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
