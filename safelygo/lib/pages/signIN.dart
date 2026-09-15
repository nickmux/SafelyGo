import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('this is a text!!!'),
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
              onPressed: null,
              child: Text("Why does this button require a child sacrifice"),
            ),
          ],
        ),
      ),
    );
  }
}
