import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm = TextEditingController();

  void _signUp(String email, String password) async {
    try {
      if ((confirm.text.compareTo(password) == 1)) {
        print("working twin");
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Column(
              mainAxisAlignment: .center,
              children: <Widget>[
                const Text('Passwords do not match.'),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      } else if ((password.length < 8)) {
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Column(
              mainAxisAlignment: .center,
              children: <Widget>[
                const Text('Password must be at minimum of 8 characters.  '),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      } else {
        auth.createUserWithEmailAndPassword(email: email, password: password);
        print("working twin");
      }
    } catch (FirebaseAuthException) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Column(
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            children: <Widget>[
              const Text('This is a typical dialog.'),
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
      );
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up for SafelyGo',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight(400)),
              ),
              SizedBox(height: 64),
              TextField(
                decoration: InputDecoration(
                  hint: Text("First Name"),
                  label: Text('First Name'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 64),
              TextField(
                decoration: InputDecoration(
                  hint: Text("Last Name"),
                  label: Text('Last Name'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 64),
              TextField(
                decoration: InputDecoration(
                  hint: Text("Email"),
                  label: Text('Email'),
                  border: OutlineInputBorder(),
                ),
                controller: email,
              ),
              SizedBox(height: 64),
              TextField(
                decoration: InputDecoration(
                  hint: Text("Password"),
                  label: Text('Password'),
                  border: OutlineInputBorder(),
                ),
                controller: password,
              ),
              SizedBox(height: 64),
              TextField(
                decoration: InputDecoration(
                  hint: Text("Comfirm Password"),
                  label: Text('Comfirm Password'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  _signUp(email.text, password.text);
                },
                child: Text("Create Account"),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
