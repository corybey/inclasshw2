import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String displayName;
  final String email;

  AppUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.email,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'email': email,
      'createdAt': Timestamp.now(),
    };
  }

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser(
      uid: data['uid'] ?? doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
    );
  }

  AppUser copyWith({
    String? firstName,
    String? lastName,
    String? displayName,
  }) {
    return AppUser(
      uid: uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName,
      email: email,
    );
  }
}
