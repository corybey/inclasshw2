import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

class MessageService {
  final CollectionReference _messagesRef =
      FirebaseFirestore.instance.collection('messages');

  Stream<List<Message>> streamMessagesForBoard(String boardId) {
    return _messagesRef
        .where('boardId', isEqualTo: boardId)
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
    });
  }

  Future<void> sendMessage({
    required String boardId,
    required String text,
    required String userId,
    required String userDisplayName,
  }) {
    return _messagesRef.add({
      'boardId': boardId,
      'text': text,
      'userId': userId,
      'userDisplayName': userDisplayName,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
