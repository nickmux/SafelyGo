import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safely_go/Models/ReportModel.dart';

class EmergencyContactWidget extends StatelessWidget {
  const EmergencyContactWidget({
    super.key,
    required this.number,
    required this.name,
  });

  final String number;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(name),
            subtitle: Text(number),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState() {
                    print("button");
                  }
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
