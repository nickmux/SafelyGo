import 'package:firebase_auth/firebase_auth.dart';
import 'package:safely_go/Components/report_widget.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:safely_go/Components/user_to_trust_widget.dart';
import 'package:safely_go/Models/ReportModel.dart';
import 'package:safely_go/Models/UserModel.dart';
import 'package:safely_go/pages/report_creation_page.dart';

class TrustedUserList extends StatefulWidget {
  const TrustedUserList({super.key});

  @override
  State<TrustedUserList> createState() => _TrustedUserState();
  // This widget is the root of your application.
}

class _TrustedUserState extends State<TrustedUserList> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference user = FirebaseFirestore.instance.collection(
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
              "My Trusted Users",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight(300)),
            ),
            StreamBuilder(
              stream: user.doc(auth.currentUser!.uid).snapshots(),
              builder: (((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("Loading");
                }
                UserModel currentUser = UserModel.fromDocument(snapshot.data!);
                List<String> trusted = currentUser.trustedUsers;
                return StreamBuilder(
                  stream: user
                      .where(FieldPath.documentId, whereIn: trusted)
                      .snapshots(),
                  builder: ((context, snapshots) {
                    if (snapshot.hasError) {
                      return const Text("Loading");
                    }
                  }),
                );
              })),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) => ReportCreationLive()),
          );
        },
      ),
    );
  }
}
