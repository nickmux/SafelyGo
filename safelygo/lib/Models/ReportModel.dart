import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String title;
  final String id;
  final String type;
  final String description;
  final String status = "Pending";
  final String fromUser;
  final DateTime dateCreated;

  ReportModel({
    required this.title,
    required this.description,
    required this.type,
    required this.fromUser,
    required this.dateCreated,
    this.id = "",
  });

  // Converts to a firestore document
  Map<String, dynamic> toDocument() {
    return {
      'title': title, // The Title
      "description": description,
      'type': type, // How pressing it is
      'status': status, //The current status of the report
      'from-user': fromUser, //User who created it
      // Firestore automatically converts Dart's DateTime into a Timestamp
      'createdAt': dateCreated,
    };
  }

  factory ReportModel.fromDocument(DocumentSnapshot doc) {
    final report = doc.data() as Map<String, dynamic>? ?? {}; //
    return ReportModel(
      id: doc.id,
      description: doc["description"] as String? ?? "",
      type: doc["type"] as String? ?? "",
      fromUser: doc["from-user"] as String? ?? "",
      dateCreated: (doc["createdAt"] as Timestamp?)!.toDate(),
      title: doc["title"] as String? ?? "",
    );
  }
}
