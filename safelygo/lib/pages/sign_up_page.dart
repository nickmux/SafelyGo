import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safely_go/pages/main_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> saveUserInFireStore(String? uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection(
      'users',
    ); //Gets a reference to the reports collection in firebase.

    // Firestore creates the ID when saving
    DocumentReference docRef = await users.add({
      "uid": uid,
    }); //adds the report to the database when ready
  }

  Future<void> _signUp(String email, String password, String username) async {
    if (_formKey.currentState!.validate()) {
      try {
        auth.createUserWithEmailAndPassword(email: email, password: password);
        auth.currentUser?.updateDisplayName(username);
        print("User logged in with: $email with the username $username");

        auth.authStateChanges().listen((user) {
          if (user != null) {
            Navigator.push(
              context,

              MaterialPageRoute<void>(builder: (context) => Hub()),
            );
            if (auth.currentUser?.uid != null) {
              saveUserInFireStore(auth.currentUser?.uid);
            }
          }
        });
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Column(
              mainAxisSize: .min,
              mainAxisAlignment: .center,
              children: <Widget>[
                Text("$e"),
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      print("Form invalid for one of the following displayed on screen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Card(
          margin: EdgeInsetsGeometry.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up for SafelyGo',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight(400)),
                ),
                SizedBox(height: 64),
                TextFormField(
                  decoration: InputDecoration(
                    hint: Text("Username"),
                    label: Text('Username'),
                    border: OutlineInputBorder(),
                  ),
                  controller: username,
                  validator: (value) {
                    if (value == "") {
                      return "Please Enter a username";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 64),
                AutofillGroup(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hint: Text("Email"),
                      label: Text('Email'),
                      border: OutlineInputBorder(),
                    ),
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      final emailRegex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      );

                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 64),
                AutofillGroup(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hint: Text("Password"),
                      label: Text('Password'),
                      border: OutlineInputBorder(),
                    ),
                    controller: password,
                    validator: (value) {
                      if (value!.length < 8) {
                        return "Password is too short, Must be a minimum of 8 Characters";
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return "Must Contain an Uppercase Letter";
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return "Must Contain an Uppercase Letter";
                      }
                      if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Must contain at least one special character (e.g., @, #, !)';
                      }
                      if (value.isEmpty) {
                        return "Please enter a password.";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 64),
                TextFormField(
                  decoration: InputDecoration(
                    hint: Text("Comfirm Password"),
                    label: Text('Comfirm Password'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != password.text) {
                      return "Passwords do not match";
                    }
                    if (value!.isEmpty) {
                      return "Please confirm your password.";
                    }
                  },
                ),
                SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {
                    _signUp(email.text, password.text, username.text);
                  },
                  child: Text("Create Account"),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
