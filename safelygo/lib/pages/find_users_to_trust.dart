import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:safely_go/Components/user_to_trust_widget.dart';
import 'package:safely_go/Models/UserModel.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final CollectionReference users = FirebaseFirestore.instance.collection(
      "users",
    );
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(32),
        child: Column(
          children: [
            SizedBox(height: 32),
            Text(
              "Find People you trust.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight(300)),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .snapshots(),
              builder: (context, snapshots) {
                if (!snapshots.hasData) {
                  return const Text("Loading");
                }

                return ListView.builder(
                  itemCount: snapshots.data?.docs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshots.data!.docs[index];
                    UserModel user = UserModel.fromDocument(doc);

                    return UserWidget(user: user);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
