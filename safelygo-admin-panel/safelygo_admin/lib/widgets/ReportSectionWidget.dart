import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safelygo_admin/Models/ReportModel.dart';
import 'package:safelygo_admin/firebase.dart';
import 'package:safelygo_admin/widgets/ReportWidget.dart';

class Reportsectionwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseTools.reports
            .where(FieldPath.documentId, isNotEqualTo: "placeholder")
            .snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Failed to retrieve SafelyGo's Reports");
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              DocumentSnapshot doc = snapshot.data!.docs[index];
              ReportModel report = ReportModel.fromDocument(doc);

              return ReportWidget(model: report);
            },
          );
        }),
      ),
    );
  }
}
