import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final DateTime registeredAt;
  final DateTime? dob;

  AppUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.registeredAt,
    this.dob,
  });

  String get displayName => '$firstName $lastName';

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'registeredAt': Timestamp.fromDate(registeredAt),
      'dob': dob != null ? Timestamp.fromDate(dob!) : null,
    };
  }

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final registeredTs = data['registeredAt'] as Timestamp;
    final dobTs = data['dob'] as Timestamp?;
    return AppUser(
      uid: data['uid'],
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      registeredAt: registeredTs.toDate(),
      dob: dobTs?.toDate(),
    );
  }
}
