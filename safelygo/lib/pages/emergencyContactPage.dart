import 'package:firebase_auth/firebase_auth.dart';
import 'package:safely_go/Components/emergency_contact_widget.dart';
import 'package:safely_go/Components/report_widget.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:safely_go/Models/ReportModel.dart';
import 'package:safely_go/pages/report_creation_page.dart';

class EmergencyContactPage extends StatelessWidget {
  const EmergencyContactPage({super.key});
  @override
  Widget build(BuildContext context) {
    final List<EmergencyContactWidget> list = [
      EmergencyContactWidget(number: "989-615-6475", name: "Nick"),
      EmergencyContactWidget(number: "989-111-1111", name: "Nerd"),
      EmergencyContactWidget(number: "989-122-2222", name: "Nerd"),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(32),
        child: Column(
          children: [
            SizedBox(height: 32),
            Text(
              "Contacts",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight(300)),
            ),
            ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => list[index],
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
