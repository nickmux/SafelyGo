import 'package:flutter/material.dart';

class signUp extends StatelessWidget {
  const signUp({super.key});
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
              ),
              SizedBox(height: 64),
              TextField(
                decoration: InputDecoration(
                  hint: Text("Password"),
                  label: Text('Password'),
                  border: OutlineInputBorder(),
                ),
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
                  print("sign up button pressed");
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
