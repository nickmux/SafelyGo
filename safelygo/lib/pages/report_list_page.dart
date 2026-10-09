import 'package:safely_go/Components/report_widget.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final CollectionReference reports = FirebaseFirestore.instance.collection(
      "reports",
    );
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
              stream: reports.snapshots(),
              builder: (context, snapshots) {
                if (!snapshots.hasData) {
                  return const Text("Loading");
                }

                return ListView.builder(
                  itemCount: snapshots.data?.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      ReportCard(documentSnapshot: snapshots.data!.docs[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
