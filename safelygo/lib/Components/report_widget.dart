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
            subtitle: const Text("Phoenix keeps calling his creations Jerrys"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [TextButton(onPressed: null, child: Text("Status"))],
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
