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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: Padding(
                        padding: const .all(64.0),
                        child: Column(
                          mainAxisSize: .min,
                          mainAxisAlignment: .center,
                          children: <Widget>[
                            Text(
                              report.title,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight(900),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Description:",
                              style: TextStyle(fontWeight: FontWeight(900)),
                            ),
                            const SizedBox(height: 15),
                            Expanded(flex: 1, child: Text(report.description)),
                            const SizedBox(height: 15),
                            Text(
                              "Status:",
                              style: TextStyle(fontWeight: FontWeight(900)),
                            ),
                            const SizedBox(height: 15),
                            Text("Status:" + report.status),
                            const SizedBox(height: 15),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
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
