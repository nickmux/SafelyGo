import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:safely_go/Components/trusted_widgets.dart';
import 'package:safely_go/Models/UserModel.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final CollectionReference users = FirebaseFirestore.instance.collection(
      "users",
    );
    //instance of a auth
    final FirebaseAuth auth = FirebaseAuth.instance;
    //Current user's uid
    final TextEditingController shareCodeController = TextEditingController();
    final String currentUser = auth.currentUser!.uid;
    final String _shareCode = auth.currentUser!.uid.substring(0, 9);
    final _formKey = GlobalKey<FormState>();
    Future<void> _addTrustedUser(String shareCode) async {
      if (_formKey.currentState!.validate() && _shareCode != shareCode) {
        QuerySnapshot<Object?> doc = await users
            .where("Share-Code", isEqualTo: shareCode)
            .get();
        if (shareCode.isNotEmpty) {
          String s = doc.docs.first.id;
          print("Validating");
          users.doc(currentUser).update({
            "Trusted-Users": FieldValue.arrayUnion([s]),
          });
        }
      }
    }

    print(_shareCode);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(32),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 32),
              Text(
                "Trust a User",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight(360)),
              ),
              Text(
                "To have a user trust you, share this code with them: $_shareCode",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 34),
              Text(
                "Wanna add a user yourself? Type the user's share code here!",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hint: Text("Unique User Code"),
                        label: Text("Unique User Code"),
                        border: OutlineInputBorder(),
                      ),
                      controller: shareCodeController,
                    ),
                    SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        _addTrustedUser(shareCodeController.text);
                      },
                      child: Text("Add User"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Card(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Users you trust",
                        style: TextStyle(
                          fontWeight: FontWeight(360),
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(height: 32),
                      StreamBuilder(
                        stream: users.doc(currentUser).snapshots(),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: Text("Loading"));
                          }

                          UserModel model = UserModel.fromDocument(
                            snapshot.data!,
                          );
                          List<String> trusted = model.trustedUsers;
                          if (trusted.isEmpty) {
                            return Center(child: Text("No Users trusted"));
                          }
                          return StreamBuilder(
                            stream: users
                                .where(FieldPath.documentId, whereIn: trusted)
                                .snapshots(),
                            builder: ((context, snapshots) {
                              if (!snapshots.hasData) {
                                return Text("wow");
                              }

                              return ListView.builder(
                                itemCount: snapshots.data!.docs.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  QueryDocumentSnapshot doc =
                                      snapshots.data!.docs[index];
                                  UserModel user = UserModel.fromDocument(doc);
                                  return UserWidget(user: user);
                                },
                              );
                            }),
                          );
                        }),
                      ),
                      SizedBox(height: 64),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
