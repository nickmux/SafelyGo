import 'package:flutter/material.dart';
import 'package:safely_go/Models/ReportModel.dart';
import 'package:safely_go/main.dart';

class ReportInfo extends StatelessWidget {
  const ReportInfo({super.key, required this.report});
  final ReportModel report;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(report.title)),

      body: Center(
        child: Column(
          children: [
            Text(
              report.title,
              style: TextStyle(fontWeight: FontWeight(900), fontSize: 64),
            ),
            SizedBox(height: 32),
            Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight(900), fontSize: 64),
            ),
            SizedBox(height: 32),
            Text(
              report.description,
              style: TextStyle(fontWeight: FontWeight(500), fontSize: 32),
            ),
            SizedBox(height: 32),
            Text(
              "Date Created:",
              style: TextStyle(fontWeight: FontWeight(900), fontSize: 64),
            ),
            SizedBox(height: 32),
            Text(report.dateCreated.toString()),
            SizedBox(height: 32),
            Text("SURRRE"),
            Text(report.status),
          ],
        ),
      ),
    );
  }
}
