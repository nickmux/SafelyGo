import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:safely_go/Components/user_to_trust_widget.dart';
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
    final String _currentUser = auth.currentUser!.uid;
    final String _shareCode = auth.currentUser!.uid.substring(0, 9);
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight(300)),
              ),
              Text("To trust a user Share this code with them: $_shareCode"),
              SizedBox(height: 64),
              Text(
                "Wanna add a user instead? Type the user's share code here!",
              ),
              SizedBox(height: 32),
              TextFormField(),
              SizedBox(height: 32),
              Card(
                child: Center(
                  child: Column(children: [Text("Users you trust")]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
