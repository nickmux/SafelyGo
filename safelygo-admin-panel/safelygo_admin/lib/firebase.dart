import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTools {
  //Reference to report collection
  static CollectionReference reports = FirebaseFirestore.instance.collection(
    "reports",
  );

  static CollectionReference user = FirebaseFirestore.instance.collection(
    "users",
  );

  


}
