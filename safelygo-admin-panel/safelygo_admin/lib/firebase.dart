import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTools {
  //Reference to report collection
  final CollectionReference reports = FirebaseFirestore.instance.collection(
    "reports",
  );

  final CollectionReference user = FirebaseFirestore.instance.collection(
    "users",
  );


}
