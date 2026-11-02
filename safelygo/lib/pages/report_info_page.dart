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

      body: Padding(
        padding: EdgeInsetsGeometry.all(32),
        child: Column(
          children: [
            Text(
              report.title,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight(300)),
            ),
            SizedBox(height: 32),
            Card(child: Text(report.description)),
            SizedBox(height: 32),
            Card(child: Text(report.dateCreated.toString())),
            SizedBox(height: 128),
            Card(child: Text(report.status)),
          ],
        ),
      ),
    );
  }
}
