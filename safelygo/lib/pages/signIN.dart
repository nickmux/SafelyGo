import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign Up', textScaler: TextScaler.linear(2)),
            TextField(
              decoration: InputDecoration(
                hint: Text("First Name"),
                label: Text('First Name'),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hint: Text("Last Name"),
                label: Text('Last Name'),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hint: Text("Email"),
                label: Text('Email'),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hint: Text("Password"),
                label: Text('Password'),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hint: Text("Comfirm Password"),
                label: Text('Comfirm Password'),
                border: OutlineInputBorder(),
              ),
            ),
            FilledButton(
              onPressed: () {
                print("jerry");
              },
              child: Text("Why does this button require a child sacrifice"),
            ),
          ],
        ),
      ),
    );
  }
}
