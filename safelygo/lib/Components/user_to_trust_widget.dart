import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safely_go/Models/ReportModel.dart';
import 'package:safely_go/Models/UserModel.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person_3_outlined),
            title: Text(user.name),
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
                child: Text("Add to trusted users"),
              ),
            ],
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
