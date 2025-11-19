import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String boardId;
  final String text;
  final String userId;
  final String userDisplayName;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.boardId,
    required this.text,
    required this.userId,
    required this.userDisplayName,
    required this.createdAt,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final ts = data['createdAt'] as Timestamp?;
    return Message(
      id: doc.id,
      boardId: data['boardId'] ?? '',
      text: data['text'] ?? '',
      userId: data['userId'] ?? '',
      userDisplayName: data['userDisplayName'] ?? '',
      createdAt: ts?.toDate() ?? DateTime.now(),
    );
  }
}
