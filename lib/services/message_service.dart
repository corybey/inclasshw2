import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';
// methods to send messages and listen for messages
class MessageService {
  final CollectionReference _messagesRef =
      FirebaseFirestore.instance.collection('messages');

  Future<void> sendMessage({
    required String boardId,
    required String text,
    required String userId,
    required String userDisplayName,
  }) async {
    await _messagesRef.add({
      'boardId': boardId,
      'text': text,
      'userId': userId,
      'userDisplayName': userDisplayName,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
//listen to all messages and order them by time
  Stream<List<Message>> streamMessagesForBoard(String boardId) {
    return _messagesRef
        .where('boardId', isEqualTo: boardId)
        .orderBy('createdAt')               //sort by time
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Message.fromFirestore(doc))
          .toList();
    });
  }
}
