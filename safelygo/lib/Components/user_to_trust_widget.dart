import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safely_go/Models/UserModel.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.user});

  final UserModel user;
  Future<void> _addTrustedUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
          "Trusted-Users": FieldValue.arrayUnion([user.uid]),
        });
  }

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
                  _addTrustedUser();
                  print("Works");
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
