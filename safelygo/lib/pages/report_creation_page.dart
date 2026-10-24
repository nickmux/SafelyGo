import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportCreationLive extends StatefulWidget {
  const ReportCreationLive({super.key});

  @override
  ReportCreationPage createState() => ReportCreationPage();
}

class ReportCreationPage extends State<ReportCreationLive> {
  final type = ["Not that Serious", "Pressing", "Emergency"];
  String? value = "Not that Serious";
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  Future<void> saveReport(String title, String description, String type) async {
    CollectionReference reports = FirebaseFirestore.instance.collection(
      'reports',
    ); //Gets a reference to the reports collection in firebase.

    // Firestore creates the ID when saving
    DocumentReference docRef = await reports.add({
      'title': title,
      'description': description,
      'type': type,
      'status': "Pending",
      'from-user': FirebaseAuth.instance.currentUser?.uid,
    }); //adds the report to the database when ready

    print("Document created with ID: ${docRef.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(32),
        child: Column(
          children: [
            Text(
              "Report a Concern",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight(300)),
            ),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                hint: Text("Title"),
                label: Text("Title"),
                border: OutlineInputBorder(),
              ),
              controller: title,
            ),
            SizedBox(height: 32),
            TextFormField(
              maxLines: 10,
              decoration: InputDecoration(
                hint: Text("Description"),
                label: Text("Description"),
                border: OutlineInputBorder(),
              ),
              controller: description,
            ),
            SizedBox(height: 128),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  items: type.map(buildOptions).toList(),
                  value: value,
                  onChanged: (String? value) {
                    setState(() {
                      this.value = value;
                    });
                    print(value);
                  },
                ),

                OutlinedButton(
                  onPressed: () {
                    saveReport(title.text, description.text, value!);
                    Navigator.pop(context);
                  },
                  child: Text("Submit report", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildOptions(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
}
