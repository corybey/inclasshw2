import 'package:flutter/material.dart';

import '../../models/board.dart';
import '../../widgets/app_drawer.dart';
import '../chat/chat_screen.dart';
//shows chat boards
class BoardsHomeScreen extends StatelessWidget {
  static const String routeName = '/boards';

  const BoardsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Message Boards')),
      // Drawer with navigation to profile/settings
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: kBoards.length,
        itemBuilder: (context, index) {
          final board = kBoards[index];
          return ListTile(
            leading: Text(board.icon, style: const TextStyle(fontSize: 24)),
            title: Text(board.name),
            subtitle: Text(board.description),
            onTap: () {
              Navigator.pushNamed(
                context,
                ChatScreen.routeName,
                arguments: board,
              );
            },
          );
        },
      ),
    );
  }
}
