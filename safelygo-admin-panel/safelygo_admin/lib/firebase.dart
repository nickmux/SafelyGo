import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTools {
  //Reference to report collection
  static CollectionReference reports = FirebaseFirestore.instance.collection(
    "reports",
  );

  static CollectionReference user = FirebaseFirestore.instance.collection(
    "users",
  );

  static Future<void> updateReportStatud(String id, String newStatus) async {
    await FirebaseFirestore.instance
        .collection("reports")
        .doc(id) // Replaced the redundant .where query lookup
        .update({"status": newStatus});
  }
}
