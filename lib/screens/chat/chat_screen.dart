import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/board.dart';
import '../../models/message.dart';
import '../../models/app_user.dart';
import '../../services/message_service.dart';
import '../../services/user_service.dart';
import '../../widgets/message_bubble.dart';
import '../../widgets/message_input.dart';
//chat shown depending on the specific board accessed
class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';

  final Board board;

  const ChatScreen({super.key, required this.board});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageService _messageService = MessageService();
  final UserService _userService = UserService();

  AppUser? _currentAppUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserProfile();
  }
//load current user profile
  Future<void> _loadCurrentUserProfile() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;

    final appUser = await _userService.getUser(firebaseUser.uid);
    if (!mounted) return;
    setState(() {
      _currentAppUser = appUser;
    });
  }
// send messages
  Future<void> _sendMessage(String text) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final displayName = _currentAppUser?.displayName ??
        _currentAppUser?.fullName ??
        user.email ??
        'Unknown';

    await _messageService.sendMessage(
      boardId: widget.board.id,
      text: text,
      userId: user.uid,
      userDisplayName: displayName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
//message list
    return Scaffold(
      appBar: AppBar(title: Text(widget.board.name)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream:
                  _messageService.streamMessagesForBoard(widget.board.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data ?? [];
                if (messages.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe =
                        currentUser != null && currentUser.uid == msg.userId;

                    return MessageBubble(
                      message: msg,
                      isMe: isMe,
                    );
                  },
                );
              },
            ),
          ),
          //new message input
          MessageInput(onSend: _sendMessage),
        ],
      ),
    );
  }
}



