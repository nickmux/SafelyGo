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

  Future<void> _removeTrustedUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
          "Trusted-Users": FieldValue.arrayRemove([user.uid]),
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
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  }

                  UserModel model = UserModel.fromDocument(snapshot.data!);

                  for (String s in model.trustedUsers) {
                    if (s == user.uid) {
                      return TextButton(
                        onPressed: _removeTrustedUser,
                        child: Text("Remove Trusted User"),
                      );
                    }
                  }
                  return TextButton(
                    onPressed: _addTrustedUser,
                    child: Text("Add Trusted User"),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
