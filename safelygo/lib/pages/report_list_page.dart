import 'package:firebase_auth/firebase_auth.dart';
import 'package:safely_go/Components/report_widget.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:safely_go/Models/ReportModel.dart';
import 'package:safely_go/pages/report_creation_page.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final CollectionReference reports = FirebaseFirestore.instance.collection(
      "reports",
    );
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(32),
        child: Column(
          children: [
            SizedBox(height: 32),
            Text(
              "Reports",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight(300)),
            ),
            StreamBuilder(
              stream: reports
                  .where("from-user", isEqualTo: auth.currentUser?.uid)
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
                    if (snapshots.data!.docs[index].exists) {
                      DocumentSnapshot doc = snapshots.data!.docs[index];
                      return ReportCard(report: ReportModel.fromDocument(doc));
                    }
                  },
                );
              },
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
