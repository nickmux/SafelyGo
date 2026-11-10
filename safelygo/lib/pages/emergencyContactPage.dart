import 'package:safely_go/Components/emergency_contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:safely_go/pages/report_creation_page.dart';

class EmergencyContactPage extends StatelessWidget {
  const EmergencyContactPage({super.key});
  @override
  Widget build(BuildContext context) {
    final List<EmergencyContactWidget> list = [
      EmergencyContactWidget(number: "800-212-1213", name: "School "),
      EmergencyContactWidget(number: "989-332-3434", name: ""),
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
