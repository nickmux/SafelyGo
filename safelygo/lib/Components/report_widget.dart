import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.documentSnapshot});

  final DocumentSnapshot documentSnapshot;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.safety_check),
            title: Text(documentSnapshot['title']),
            subtitle: Text(documentSnapshot['description']),
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
                              documentSnapshot['title'],
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
                            Expanded(
                              flex: 1,
                              child: Text(documentSnapshot['description']),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Status:",
                              style: TextStyle(fontWeight: FontWeight(900)),
                            ),
                            const SizedBox(height: 15),
                            Text("Status:" + documentSnapshot['status']),
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
