import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String uid;
  final GeoPoint location;
  final List<String> trustedUsers;

  UserModel({
    required this.name,
    required this.uid,
    this.location = const GeoPoint(0, 0),
    this.trustedUsers = const [],
  });

  // Converts to a firestore document
  Map<String, dynamic> toDocument() {
    return {
      "id": uid,
      'Username': name, // The Title
      "Location": location,
      "Trusted-Users": trustedUsers,
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final user = doc.data() as Map<String, dynamic>? ?? {}; //
    return UserModel(
      uid: doc.id,
      name: doc["Username"] as String? ?? "",
      trustedUsers: doc["Trusted-Users"] as List<String>? ?? [],
      location: doc["Location"] as GeoPoint? ?? GeoPoint(0, 0),
    );
  }
}
