import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safely_go/Models/ReportModel.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.report});

  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.safety_check),
            title: Text(report.title),
            subtitle: Text(report.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  null;
                },
                child: Text("Status"),
              ),
            ],
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
