import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class UserService {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(AppUser user) {
    return _usersRef.doc(user.uid).set(user.toMap());
  }

  Future<AppUser?> getUser(String uid) async {
    final doc = await _usersRef.doc(uid).get();
    if (!doc.exists) return null;
    return AppUser.fromFirestore(doc);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) {
    return _usersRef.doc(uid).update(data);
  }
}
